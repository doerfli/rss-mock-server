FROM ruby:2.7.0-alpine

RUN apk update && apk upgrade && \
    apk add --update nodejs build-base libxml2 libxml2-dev libxml2-utils libxslt-dev tzdata && \
    apk add postgresql-dev && \
    rm -rf /var/cache/apk/*

ENV HOME /app
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV SECRET_KEY_BASE abcdefgh12345678
EXPOSE 3000

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN gem update bundler
# speed up install of nokogiri gem
RUN bundle config --local build.nokogiri --use-system-libraries
RUN bundle install --without development test

# Add the app code
COPY . $HOME

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
