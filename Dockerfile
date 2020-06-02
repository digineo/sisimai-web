FROM ruby:2.7-alpine

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN set -ex \
 && apk add --no-cache make gcc libc-dev \
 && bundle config set deployment "true" \
 && bundle install --without="development,test"

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "ruby", "/app/app.rb"]
