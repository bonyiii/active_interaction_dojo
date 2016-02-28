Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

require 'cuba'

Dotenv.load
DB = Sequel.connect(ENV["DATABASE_URL_#{ENV.fetch('RACK_ENV', 'development').upcase}"])

require './interaction_app'
Dir["./app/**/*.rb"].each { |file| require file }
