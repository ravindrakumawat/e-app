FROM ruby:2.7.4

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.1.4
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true

WORKDIR $APP_PATH
RUN mkdir -p $APP_PATH 

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  openssh-client \
  default-mysql-client \
  sqlite3 \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  tzdata \
  less \
  vim \
  nano \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY . .
RUN gem install bundler --version "$BUNDLE_VERSION" && rm -rf $GEM_HOME/cache/*
RUN bundle config --global frozen 1
RUN bundle install

EXPOSE $RAILS_PORT

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]