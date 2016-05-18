#!/bin/bash

read RUBY_VERSION < .ruby-version
read RUBY_GEMSET < .ruby-gemset

. $(dirname $0)/rvm_config.sh
rvm install --quiet-curl ruby-$RUBY_VERSION
rvm gemset use $RUBY_GEMSET
gem install bundler
bundle install
rake db:create
rake db:migrate
rake db:test:prepare

echo <<INSTRUCTIONS
All done! To check everything's OK, run

  rvm gemset use $RUBY_GEMSET
  rake

INSTRUCTIONS
