# syntax=docker/dockerfile:1
FROM ruby:3.3-alpine

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

# hadolint ignore=DL3018
RUN <<BASH
  set -ex

  apk add --no-cache --virtual build-dependencies \
    make \
    gcc \
    libc-dev

  bundle config set --local deployment "true"
  bundle config set --local without "development test"
  bundle install

  apk del build-dependencies
BASH

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "ruby", "/app/app.rb"]
