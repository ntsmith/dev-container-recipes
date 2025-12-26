# Start with the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid prompts during installations
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    wget \
    ca-certificates \
    software-properties-common \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv && \
    rm -rf /var/lib/apt/lists/*

USER ubuntu
ENV VIRTUAL_ENV=/home/ubuntu/opt/venv
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"
RUN python3 -m venv $VIRTUAL_ENV

# Install Jupyter and core data science libraries
RUN pip install --no-cache-dir \
    jupyter \
    notebook \
    jupyterlab \
    numpy \
    pandas \
    matplotlib \
    scipy \
    scikit-learn \
    seaborn \
    sympy \
    statsmodels \
    bokeh \
    plotly \
    ipywidgets \
    jupyter_contrib_nbextensions \
    music21 \
    yfinance

# Expose the default Jupyter Notebook port
EXPOSE 8888

# Configure Jupyter Notebook
RUN jupyter notebook --generate-config && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_root = True" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# Set the default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
