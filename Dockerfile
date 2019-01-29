FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /growstuff
WORKDIR /growstuff
COPY Gemfile /growstuff/Gemfile
COPY Gemfile.lock /growstuff/Gemfile.lock
RUN bundle install
COPY . /growstuff

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
