FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential

ENV PORT 4567
ENV APP_HOME /home/app

EXPOSE $PORT

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN bundle install