FROM ruby:2.7.2-alpine

RUN apk add --no-cache --update build-base postgresql-dev linux-headers nodejs git

ENV APP_PATH /usr/src/app

WORKDIR $APP_PATH

COPY . .

RUN echo "gem: --no-document" > ~/.gemrc

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

ARG PORT=3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]

EXPOSE 3000
