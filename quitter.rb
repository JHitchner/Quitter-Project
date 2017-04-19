require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
#require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
#set sessions: true
