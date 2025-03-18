# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

production:
  <<: *default
  adapter: postgresql
  database: tacogram_final_production
  username: tacogram_final
  password: <%= ENV["TACOGRAM_FINAL_DATABASE_PASSWORD"] %>

run Rails.application
Rails.application.load_server
