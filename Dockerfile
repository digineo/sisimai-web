FROM ruby:3.1-alpine

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN set -ex \
 && apk add --no-cache --virtual build-dependencies \
      make \
      gcc \
      libc-dev \
 && bundle config set deployment "true" \
 && bundle install --without="development,test" \
 && apk del build-dependencies

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "ruby", "/app/app.rb"]
