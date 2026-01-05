#!/usr/bin/env python3
"""Demo script to verify virtual environment setup."""

import sys
import os


def main():
    print("=== Python Virtual Environment Demo ===")
    print()
    print(f"Python version: {sys.version}")
    print(f"Python executable: {sys.executable}")
    print()

    # Check if running in a virtual environment
    in_venv = hasattr(sys, 'real_prefix') or (
        hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix
    )

    if in_venv:
        print("Virtual environment: ACTIVE")
        print(f"  Prefix: {sys.prefix}")
    else:
        print("Virtual environment: NOT ACTIVE")

    print()
    print("Environment setup complete!")


if __name__ == "__main__":
    main()
