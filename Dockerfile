FROM ruby:3.2.2-alpine3.17

RUN apk add --update --no-cache \
  build-base \
  shared-mime-info \
  postgresql-dev \
  tzdata \
  bash

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
