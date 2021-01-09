FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y mongodb-server ruby-full ruby-dev build-essential git --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.1.4
RUN git clone -b monolith https://github.com/express42/reddit.git

COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY Gemfile_lock /reddit/Gemfile.lock
COPY start.sh /start.sh


WORKDIR /reddit 
RUN bundle install
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
