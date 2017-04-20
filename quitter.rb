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
    redirect "/"
end

get "/sign-in" do
  erb :sign_in_form
end

get "/login-fail" do
  erb :sign_in_fail
end

post "/sign-in" do
  @user = User.where(username: params[:username]).id
  if @user.password==params[:password]
    session[:user_id]=@user.id
      if
        flash[:notice] = "Login successful!"
        redirect "/"
      else
        flash[:alert] = "Login failed."
    	redirect "/sign-in"
      end
  end
end

get "/sign-out" do
  session[user_id]=nil
end

get "/profile" do
  erb :profile
end

get "/profile_create" do
  erb :profile_create
end

get "/profile_delete" do
  erb :profile_delete
end
