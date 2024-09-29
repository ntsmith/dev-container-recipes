FROM python:3-slim

# Set the working directory in the container
WORKDIR /workspace
COPY requirements.txt requirements.txt

# Install DuckDB CLI and other dependencies
RUN apt-get update && \
    apt-get install -y build-essential curl wget && \
    pip install --upgrade pip

# Install Jupyter, DuckDB, and other necessary packages
RUN pwd
RUN pip install -r requirements.txt
# Expose the Jupyter port
EXPOSE 8888

# Set the command to launch Jupyter Notebook
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]