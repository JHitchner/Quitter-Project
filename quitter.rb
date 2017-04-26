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
    User.find(session[:user_id])
  end
end

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

def post_ten
  @posts=Post.last(10)
  @post=@posts.reverse
end

get "/" do
  if session[:user_id]
    @current_user=session[:user_id]
    puts "Show current user- #{@current_user}"
  end
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
  @profile =Profile.create(fname: params[:fname], lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio], user_id: @user.id)
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

post "/delete_acount" do
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

# get "/profile_view" do
#   if session[:user_id]
#     @current_user=session[:user_id]
#     @profile = Profile.where(user_id: @current_user).first
#     if @profile.nil?
#       @user=User.find(@current_user)
#       @profile =Profile.create(fname: params[:fname],lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio], user_id: @current_user)
#     end
#     redirect "profile_view/#{@profile.id}"
#   else
#     flash[:notice] = "Login Timed-out"
#     redirect "/"
#   end
# end

get "/profile_view/:id" do
  @profile = Profile.find(params[:id])
  if session[:user_id]
    if @current_user.nil?
      @current_user=session[:user_id]
    end
    puts "Show current user- #{@current_user}"
  end
  @profile_owner=@profile.user_id
  puts "Show profile owner- #{@profile_owner}"
  erb :profile_view
end

get "/profile_edit/:id" do
  if session[:user_id]
    @current_user=session[:user_id]
    @profile = Profile.where(user_id: @current_user).first
    @profile_owner=@profile.user_id
    # redirect "/profile_edit/#{@profile.id}"
    puts "Show current user- #{@current_user}"
  else
    flash[:notice] = "Login Timed-out"
    redirect "/"
  end
  erb :profile_edit
end

put "/profile_edit/:id" do
  puts "Show current user- #{@current_user}"
  @profile = Profile.find(params[:id])
  @profile.update(fname: params[:fname], lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio])
  @profile.save
  redirect "/profile_view/#{@profile.id}"
  # redirect "/profile_view"
end

post "/profile_edit/:id" do
  redirect "/profile_view/#{@profile.id}"
end

# //posts

get "/post_create/:id" do
  # @users = User.all
  # @posts= Post.all
  erb  :post
end

post '/post_create' do
  if session[:user_id]
    if @current_user.nil?
      @current_user=session[:user_id]
    end
    @post = Post.create(post_body: params[:post_body], post_title: params[:post_title], user_id: session[:user_id])
    puts "Show current user- #{@current_user}"
    redirect"/show-post"
  else
    flash[:alert] = "Login Timed-out"
    redirect"/"
  end
end

get "/posts" do
  erb :posts
end

get "/show-post" do
  # if session[:user_id]
  #   @post = Post.find(params[:id])
  # else
  #   flash[:alert] = "Login Timed-out"
  #   redirect"/"
  # end
  erb :posts
end
