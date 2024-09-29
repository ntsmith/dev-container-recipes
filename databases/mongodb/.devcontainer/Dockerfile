FROM python:3-slim

RUN apt-get update && \
    apt-get install -y build-essential curl wget && \
    pip install --upgrade pip

RUN pip install jupyterlab pymongo pandas matplotlib

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]