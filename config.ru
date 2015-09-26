Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

require 'cuba'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])

Cuba.define do 
  on root do
    res.write 
  end

  on post do
    on 'users' do

    end
  end
end

run Cuba
