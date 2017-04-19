require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"

#require "./models"
set :database, "sqlite3:quitterbase.sqlite3"
#set sessions, true
get "/profile" do
  erb :profile

end

get "/profile_create" do
  erb :profile_create

end

get "/profile_delete" do
  erb :profile_delete

end
