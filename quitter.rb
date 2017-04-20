require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"

#require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
#set sessions: true


get "/profile_view" do
  erb :profile_view

end

get "/profile_new" do
  erb :profile_create

end

post "/profile_new" do
  @profile = Profile.where(email: params[:email], bday: params[:bday], bio: params[:bio]).first
  redirect "/profile_view"
end


get "/profile_delete" do
  erb :profile_delete

end
