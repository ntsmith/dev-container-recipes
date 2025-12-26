FROM python:alpine

RUN apk update && apk add git

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt