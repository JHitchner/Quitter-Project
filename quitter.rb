require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
set :sessions, true

def current_user
  if session[:user_id]
    User.find(session[:user_id])
  end
end

get "/sign-up" do
  erb :sign_up_form
end

post "/sign-up" do
  User.create(
    username: params[:username],
    password: params[:password]
  )
    redirect "/profile_create"
end

get "/sign-in" do
  erb :sign_in_form
end

# get "/login-fail" do
#   erb :sign_in_fail
# end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    session[:user_id]=@user.id
    flash[:notice] = "Login successful!"
    redirect "/"
  else
    flash[:alert] = "Login failed."
    redirect "/sign-in"
  end
end

get "/sign-out" do
  session[user_id]=nil
end

get "/delete_account" do
  erb :account_delete
end

post "/delete_acount" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    User.delete(
      username: params[:id]
    )
    flash[:notice] = "Account Deleted!"
    redirect "/"
  else
  end
end

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
