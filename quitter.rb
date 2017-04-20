require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
#set sessions: true


get "/profile_view/:id" do
  erb :profile_view
	# @profile = Profile.find(params[:id])
  puts @profile.inspect
  puts params.inspect
end

get "/profile_new" do
  erb :profile_create

end

post "/profile_new" do
  puts "params", params.inspect
   @profile = Profile.create(email: params[:email], bday: params[:bday], bio: params[:bio])
  #  @profile.save
  # redirect "/profile_view/"+ @profile.id.to_s
  redirect "/"
end


get "/profile_delete" do
  erb :profile_delete

end
