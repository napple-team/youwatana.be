FROM ruby:2.6

ENV APP_DIR=/usr/src/app \
  STDOUT_SYNC=true

WORKDIR $APP_DIR

COPY Gemfile Gemfile
COPY Gemfile.lock .

RUN bundle install -j4

COPY . ${APP_DIR}

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0", "--pid", "/tmp/server.pid"]
