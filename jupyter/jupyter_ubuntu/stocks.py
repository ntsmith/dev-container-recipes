"""
Stock Market Data Analysis - Starter Notebook
Analyzing RDDT (Reddit) and BROS (Dutch Bros)
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import yfinance as yf
from datetime import datetime, timedelta
import warnings
warnings.filterwarnings('ignore')

# Set style for better-looking plots
plt.style.use('seaborn-v0_8-darkgrid')
sns.set_palette("husl")

# ============================================================================
# DATA COLLECTION FUNCTIONS
# ============================================================================

def fetch_stock_data(ticker, period='1y', interval='1d'):
    """
    Fetch stock data from Yahoo Finance
    
    Parameters:
    -----------
    ticker : str
        Stock ticker symbol (e.g., 'RDDT', 'BROS')
    period : str
        Data period: '1d','5d','1mo','3mo','6mo','1y','2y','5y','10y','ytd','max'
    interval : str
        Data interval: '1m','2m','5m','15m','30m','60m','90m','1d','5d','1wk','1mo','3mo'
    
    Returns:
    --------
    pd.DataFrame : Stock data with OHLCV columns
    """
    try:
        stock = yf.Ticker(ticker)
        data = stock.history(period=period, interval=interval)
        
        if data.empty:
            print(f"Warning: No data retrieved for {ticker}")
            return None
            
        print(f"✓ Retrieved {len(data)} rows for {ticker}")
        return data
    
    except Exception as e:
        print(f"Error fetching {ticker}: {e}")
        return None

def fetch_multiple_stocks(tickers, period='1y', interval='1d'):
    """
    Fetch data for multiple stocks
    
    Returns:
    --------
    dict : Dictionary with ticker symbols as keys and DataFrames as values
    """
    stock_data = {}
    for ticker in tickers:
        data = fetch_stock_data(ticker, period, interval)
        if data is not None:
            stock_data[ticker] = data
    return stock_data

# ============================================================================
# TECHNICAL INDICATORS
# ============================================================================

def add_moving_averages(df, windows=[20, 50, 200]):
    """Add Simple Moving Averages to dataframe"""
    df = df.copy()
    for window in windows:
        df[f'SMA_{window}'] = df['Close'].rolling(window=window).mean()
    return df

def add_returns(df):
    """Add daily and cumulative returns"""
    df = df.copy()
    df['Daily_Return'] = df['Close'].pct_change()
    df['Cumulative_Return'] = (1 + df['Daily_Return']).cumprod() - 1
    return df

def add_volatility(df, window=20):
    """Add rolling volatility (standard deviation of returns)"""
    df = df.copy()
    df['Volatility'] = df['Close'].pct_change().rolling(window=window).std()
    return df

def calculate_rsi(df, window=14):
    """Calculate Relative Strength Index"""
    df = df.copy()
    delta = df['Close'].diff()
    gain = (delta.where(delta > 0, 0)).rolling(window=window).mean()
    loss = (-delta.where(delta < 0, 0)).rolling(window=window).mean()
    rs = gain / loss
    df['RSI'] = 100 - (100 / (1 + rs))
    return df

# ============================================================================
# VISUALIZATION FUNCTIONS
# ============================================================================

def plot_price_and_volume(df, ticker, figsize=(14, 8)):
    """
    Create a two-panel plot: price with moving averages and volume
    """
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=figsize, 
                                     gridspec_kw={'height_ratios': [3, 1]})
    
    # Price plot
    ax1.plot(df.index, df['Close'], label='Close Price', linewidth=2, color='#2E86AB')
    
    # Add moving averages if they exist
    ma_colors = ['#A23B72', '#F18F01', '#C73E1D']
    for i, col in enumerate([c for c in df.columns if 'SMA' in c]):
        ax1.plot(df.index, df[col], label=col, linewidth=1.5, 
                alpha=0.7, linestyle='--', color=ma_colors[i % len(ma_colors)])
    
    ax1.set_ylabel('Price ($)', fontsize=12, fontweight='bold')
    ax1.set_title(f'{ticker} - Price and Volume', fontsize=14, fontweight='bold')
    ax1.legend(loc='best')
    ax1.grid(True, alpha=0.3)
    
    # Volume plot
    colors = ['#27AE60' if df['Close'].iloc[i] >= df['Open'].iloc[i] 
              else '#E74C3C' for i in range(len(df))]
    ax2.bar(df.index, df['Volume'], color=colors, alpha=0.6)
    ax2.set_ylabel('Volume', fontsize=12, fontweight='bold')
    ax2.set_xlabel('Date', fontsize=12, fontweight='bold')
    ax2.grid(True, alpha=0.3)
    
    plt.tight_layout()
    return fig

def plot_returns_comparison(stock_data, figsize=(14, 6)):
    """
    Compare cumulative returns across multiple stocks
    """
    fig, ax = plt.subplots(figsize=figsize)
    
    for ticker, df in stock_data.items():
        if 'Cumulative_Return' in df.columns:
            ax.plot(df.index, df['Cumulative_Return'] * 100, 
                   label=ticker, linewidth=2)
    
    ax.set_ylabel('Cumulative Return (%)', fontsize=12, fontweight='bold')
    ax.set_xlabel('Date', fontsize=12, fontweight='bold')
    ax.set_title('Cumulative Returns Comparison', fontsize=14, fontweight='bold')
    ax.legend(loc='best')
    ax.grid(True, alpha=0.3)
    ax.axhline(y=0, color='black', linestyle='-', linewidth=0.5)
    
    plt.tight_layout()
    return fig

def plot_candlestick_simple(df, ticker, last_n_days=60, figsize=(14, 8)):
    """
    Simplified candlestick chart using matplotlib
    """
    df_recent = df.tail(last_n_days).copy()
    
    fig, ax = plt.subplots(figsize=figsize)
    
    # Calculate width for bars
    width = 0.6
    
    for i, (idx, row) in enumerate(df_recent.iterrows()):
        color = '#27AE60' if row['Close'] >= row['Open'] else '#E74C3C'
        
        # Draw high-low line
        ax.plot([i, i], [row['Low'], row['High']], 
               color=color, linewidth=1, solid_capstyle='round')
        
        # Draw open-close box
        height = abs(row['Close'] - row['Open'])
        bottom = min(row['Open'], row['Close'])
        ax.bar(i, height, width, bottom=bottom, color=color, alpha=0.8)
    
    ax.set_xlabel('Date', fontsize=12, fontweight='bold')
    ax.set_ylabel('Price ($)', fontsize=12, fontweight='bold')
    ax.set_title(f'{ticker} - Candlestick Chart (Last {last_n_days} Days)', 
                fontsize=14, fontweight='bold')
    
    # Set x-axis labels
    step = max(1, len(df_recent) // 10)
    ax.set_xticks(range(0, len(df_recent), step))
    ax.set_xticklabels([df_recent.index[i].strftime('%Y-%m-%d') 
                        for i in range(0, len(df_recent), step)], 
                       rotation=45, ha='right')
    
    ax.grid(True, alpha=0.3, axis='y')
    plt.tight_layout()
    return fig

def plot_correlation_heatmap(stock_data, figsize=(8, 6)):
    """
    Create correlation heatmap of stock returns
    """
    # Create dataframe of returns
    returns_df = pd.DataFrame()
    for ticker, df in stock_data.items():
        if 'Daily_Return' in df.columns:
            returns_df[ticker] = df['Daily_Return']
    
    # Calculate correlation
    corr = returns_df.corr()
    
    fig, ax = plt.subplots(figsize=figsize)
    sns.heatmap(corr, annot=True, cmap='coolwarm', center=0, 
                square=True, linewidths=1, cbar_kws={"shrink": 0.8},
                fmt='.3f', ax=ax)
    
    ax.set_title('Stock Returns Correlation', fontsize=14, fontweight='bold')
    plt.tight_layout()
    return fig

def plot_volatility_comparison(stock_data, figsize=(14, 6)):
    """
    Compare rolling volatility across stocks
    """
    fig, ax = plt.subplots(figsize=figsize)
    
    for ticker, df in stock_data.items():
        if 'Volatility' in df.columns:
            ax.plot(df.index, df['Volatility'] * 100, 
                   label=ticker, linewidth=2)
    
    ax.set_ylabel('Volatility (%) - 20-day Rolling', fontsize=12, fontweight='bold')
    ax.set_xlabel('Date', fontsize=12, fontweight='bold')
    ax.set_title('Volatility Comparison', fontsize=14, fontweight='bold')
    ax.legend(loc='best')
    ax.grid(True, alpha=0.3)
    
    plt.tight_layout()
    return fig

# ============================================================================
# ANALYSIS FUNCTIONS
# ============================================================================

def print_summary_statistics(stock_data):
    """
    Print summary statistics for all stocks
    """
    print("\n" + "="*70)
    print("SUMMARY STATISTICS")
    print("="*70)
    
    for ticker, df in stock_data.items():
        print(f"\n{ticker}:")
        print(f"  Period: {df.index[0].strftime('%Y-%m-%d')} to {df.index[-1].strftime('%Y-%m-%d')}")
        print(f"  Current Price: ${df['Close'].iloc[-1]:.2f}")
        print(f"  Period High: ${df['High'].max():.2f}")
        print(f"  Period Low: ${df['Low'].min():.2f}")
        
        if 'Daily_Return' in df.columns:
            total_return = df['Cumulative_Return'].iloc[-1] * 100
            avg_daily_return = df['Daily_Return'].mean() * 100
            volatility = df['Daily_Return'].std() * 100
            
            print(f"  Total Return: {total_return:.2f}%")
            print(f"  Avg Daily Return: {avg_daily_return:.3f}%")
            print(f"  Daily Volatility: {volatility:.3f}%")
            print(f"  Sharpe Ratio (approx): {(avg_daily_return / volatility * np.sqrt(252)):.2f}")
