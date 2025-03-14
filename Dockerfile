FROM --platform=linux/x86_64 ruby:2.6-alpine

LABEL Name=achievemore-ruby Version=2.6

WORKDIR /app

RUN gem install bundler:2.4.21

RUN apk --update --upgrade --no-cache add \
    build-base \
    sqlite-dev \
    tzdata \
    shared-mime-info

RUN apk --update add less

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
