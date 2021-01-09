FROM python:3.6.0-alpine

WORKDIR /app
COPY . /app

RUN apk add --no-cache --virtual .build-deps musl-dev gcc linux-headers  \
    && pip install --no-cache-dir -r /app/requirements.txt \
    && apk del .build-deps

ENV POST_DATABASE_HOST=post_db \
    POST_DATABASE=posts

ENTRYPOINT ["python3", "post_app.py"]
