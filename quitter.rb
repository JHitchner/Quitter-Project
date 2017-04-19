require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
# require "./models"

set sessions, true
set :database, "sqlite3:quitterbase.sqlite3"
