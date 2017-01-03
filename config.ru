require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

if ENV['RACK_ENV'] == 'production'
  log = File.new('sinatra.log', 'a+')
  $stdout.reopen(log)
  $stderr.reopen(log)
end

use Rack::MethodOverride
use ErrorsController
use UsersController
use InviteCodeController
use LogsController
use SamplesController
use SamplesGroupController
use StylesController
use OptionsController
run ApplicationController