FROM python:3.8-alpine
MAINTAINER amry@nectico.com

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN set -ex \
 && apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    python3-dev \
 && pip install -r /requirements.txt \
 && apk del .build-deps

RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
