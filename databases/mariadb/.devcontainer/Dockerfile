FROM python:slim

RUN apt-get update && \
    apt-get install -y build-essential default-mysql-client curl wget maria libmariadb-dev && \
    pip install --upgrade pip

RUN pip install jupyterlab mysql-connector-python pandas mariadb

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]