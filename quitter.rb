require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
set :sessions, true
set :session_secret, "!~Seekr3t"

# Used to create Current User
def current_user
  if session[:user_id]
    @current_user=session[:user_id]
  end
end

# Used to query Current Users posts
def my_post
  if session[:user_id]
    @current_user=session[:user_id]
    @posts=Post.where(user_id: @current_user)
    @post=@posts.reverse
  else
    flash[:notice] = "Login Timed-out"
    redirect "/"
  end
end

# Used to query Top Ten lastest posts
def post_ten
  @posts=Post.last(10)
  @post=@posts.reverse
end

# Root Path
get "/" do
  @user = User.all
  if session[:user_id]
    @current_user=session[:user_id]
    puts "Show current user- #{@current_user}"
  end
  erb :home
end

# Users Table Routes
get "/sign-up" do
  erb :sign_up_form
end

post "/sign-up" do
  @user=User.create(
    username: params[:username],
    password: params[:password]
  )
  @profile =Profile.create(fname: params[:fname], lname: params[:lname], email: params[:email], bday: params[:bday], bio:params[:bio], user_id: @user.id)
  session[:user_id]=@user.id
  redirect "/profile_view/#{@profile.user_id}"
end

get "/sign-in" do
  erb :sign_in_form
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id]=@user.id
    @profile=Profile.where(user_id: @user.id).first
    flash[:notice] = "Login successful!"
    redirect "/"
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
  if @user && @user.password == params[:password]
    @user.delete()
    session[:user_id]=nil
    flash[:notice] = "Account Deleted!"
    redirect "/"
  else
    puts "failed to delete"
  end
end

# Profiles Table Routes
get "/profile_edit/:id" do
  if session[:user_id]
    @current_user=session[:user_id]
    @profile = Profile.find(params[:id])
    puts "Show current user- #{@current_user}"
  else
    flash[:notice] = "Login Timed-out"
    redirect "/"
  end
  erb :profile_edit
end

put "/profile_edit/:id" do
  @profile = Profile.find(params[:id])
  @profile.update(
    fname: params[:fname], lname: params[:lname],
    email:params[:email], bday:params[:bday],
    bio:params[:bio]
    )
  @profile.save
  redirect "/profile_view/#{@profile.user_id}"
end

post "/profile_edit/:id" do
  redirect "/profile_view/#{@profile.user_id}"
end

get "/profile_view/:user_id" do
  @profile = Profile.where(user_id: params[:user_id]).first
  if session[:user_id]
    if @current_user.nil?
      @current_user=session[:user_id]
    end
    puts "Show current user- #{@current_user}"
  end
  erb :profile_view
end

# Posts Table Routes
get "/post_create/:id" do
  if session[:user_id]
  	@current_user=session[:user_id]
  	puts "Show current user- #{@current_user}"
  else
  	flash[:notice] = "Login Timed-out"
  	redirect "/"
  end
  erb  :post_create
end

post '/post_create' do
  if session[:user_id]
    if @current_user.nil?
      @current_user=session[:user_id]
    end
    @post = Post.create(post_body: params[:post_body], post_title: params[:post_title], user_id: session[:user_id])
    redirect"/show-mypost/#{@current_user}"
  else
    flash[:alert] = "Login Timed-out"
    redirect"/"
  end
end

# Use to show ALL user posts
get "/posts-all" do
  @post = Post.all
  erb :posts_all
end

# Use to show ALL posts for a SINGLE User
get "/posts/:user_id" do
  @posts = Post.where(user_id: params[:user_id])
  @post=@posts.reverse
  @user=User.find(params[:user_id])
  erb :posts_user
end

# Use to show ALL posts for CURRENT USER
get "/show-mypost/:user_id" do
  @posts = Post.where(user_id: params[:user_id])
  @post=@posts.reverse
  @user=User.find(params[:user_id])
  erb :posts_my
end

# Use to show SINGLE post for CURRENT USER
get "/post-view/:id" do
  @post = Post.find(params[:id])
  if session[:user_id]
    if @current_user.nil?
      @current_user=session[:user_id]
    end
    puts "Show current user- #{@current_user}"
  end
  erb :post_view
end

get "/post-edit/:id" do
  if session[:user_id]
    @current_user=session[:user_id]
    @post = Post.find(params[:id])
    puts "Show current user- #{@current_user}"
  else
    flash[:notice] = "Login Timed-out"
    redirect "/"
  end
  erb :post_edit
end

put "/post-edit/:id" do
  @post = Post.find(params[:id])
  @post.update(post_body: params[:post_body], post_title: params[:post_title])
  @post.save
  redirect "/show-mypost/#{@post.user_id}"
end

post "/post-edit/:id" do
  redirect "/show-mypost/#{@post.user_id}"
end

get "/post-delete/:id" do
  @post = Post.find(params[:id])
  @post.delete()
  redirect "/show-mypost/#{@post.user_id}"
end

# Retrieves all routes list and displays
Sinatra::Application.routes["GET"].each do |route|
  puts route[0]
end
