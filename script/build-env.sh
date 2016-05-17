#!/bin/sh

/usr/share/rvm/bin/rvm install ruby-2.1.8
gem install bundler
bundle install
rake db:create
rake db:migrate
rake db:test:prepare
