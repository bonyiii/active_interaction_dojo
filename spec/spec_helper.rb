#require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

#require File.expand_path '../../my-app.rb', __FILE__

require './config/env'

Sequel.extension :migration
Sequel::Migrator.run(DB, 'db/migrations', target: 0)
Sequel::Migrator.run(DB, 'db/migrations')
