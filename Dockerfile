FROM python:3.8-alpine
MAINTAINER amry@nectico.com

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN set -ex \
 && apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    linux-headers \
    postgresql-dev \
    musl-dev \
    python3-dev \
 && pip install -r /requirements.txt \
 && apk del .build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
