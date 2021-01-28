ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

def fi_check_migration
  ActiveRecord::Migration.check_pending!
rescue ActiveRecord::PendingMigrationError
  raise ActiveRecord::PendingMigrationError, <<~EX_MSG
    Migrations are pending. To resolve this issue, run:
          rake db:migrate SINATRA_ENV=test
  EX_MSG
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app/models/concerns'
require_all 'app'
require_all 'lib'
