# syntax=docker/dockerfile:1

FROM ruby:3.3.6-slim

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git \
  curl \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=production

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:prepare && bundle exec rails assets:precompile && bundle exec rails server -b 0.0.0.0 -p $PORT"]
