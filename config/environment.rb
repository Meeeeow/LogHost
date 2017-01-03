ENV['RACK_ENV'] ||='development'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['RACK_ENV']}.sqlite"
)

require_all 'app'