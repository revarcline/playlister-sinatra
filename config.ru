require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  use GenresController
  use SongsController
  use ArtistsController
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => e
  warn e
  exit 1
end
