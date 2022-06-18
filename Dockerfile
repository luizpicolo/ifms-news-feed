FROM ruby:3.1.2

ENV RACK_ENV production

WORKDIR /code
COPY . /code

RUN bundle install

EXPOSE 4567