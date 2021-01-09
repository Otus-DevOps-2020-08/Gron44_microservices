FROM ubuntu:20.04
RUN apt-get update \
    && apt-get install -y ruby-full ruby-dev build-essential --no-install-recommends\
    && gem install bundler -v '~>1.17.2' --no-document

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . $APP_HOME
RUN bundle install

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV COMMENT_DATABASE_HOST=comment_db \
    COMMENT_DATABASE=comments 

CMD ["puma"]