Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

require 'cuba'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])

require './app'
Dir["./app/**/*.rb"].each { |file| require file }
