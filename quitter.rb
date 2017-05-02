require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
set :sessions, true
set :session_secret, "!~Seekr3t"

def current_user
  if session[:user_id]
    User.find(session [:user_id])
  end
end

def post_ten
  @posts=Post.last(10)
  @post=@posts.reverse
end

get "/" do
  @posts = Post.all
  erb :home
end

get "/sign-up" do
  erb :sign_up_form
end

post "/sign-up" do
  @user=User.create(
    username: params[:username],
    password: params[:password]
  )
  @profile =Profile.create(
    fname: params[:fname],lname: params[:lname],
    email:params[:email], bday:params[:bday],
    bio:params[:bio], user_id: @user.id
  )
    session[:user_id]=@user.id
    redirect "profile_view/#{@profile.id}"
end

get "/sign-in" do
  erb :sign_in_form
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    session[:user_id]=@user.id
    @profile=Profile.where(user_id: @user.id).first
    flash[:notice] = "Login successful!"
    redirect "/profile_view/#{@profile.id}"
  else
    flash[:notice] = "Login failed."
    redirect "/sign-in"
  end
end

get "/sign-out" do
  session[:user_id]=nil
  redirect "/"
end

get "/delete_account" do
  puts "Show current user- #{@current_user}"
  erb :account_delete
end

post "/delete_account" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    @user.delete()
    session[:user_id]=nil
    flash[:notice] = "Account Deleted!"
    redirect "/"
  else
    puts "failed to delete"
  end
end

get "/profile_view/:id" do
  @profile = Profile.find(params[:id])
  @current_user=session[:user_id]
  erb :profile_view
end

put "/profile_edit/:id" do
  @profile = Profile.find(params[:id])
  @profile.update(
    fname: params[:fname], lname: params[:lname],
    email:params[:email], bday:params[:bday],
    bio:params[:bio]
    )
  @profile.save
  redirect "/profile_view/#{@profile.id}"
end

# //posts
