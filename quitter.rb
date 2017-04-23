require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
<<<<<<< HEAD
enable :sessions

def current_user
  if session[:user_id]
    User.find(session[:user_id])
  end
end

get "/" do
  session[:user_id]=nil
  @post = Post.all
=======
set :sessions, true
set :session_secret, "!~Seekr3t"

# def current_user
#   if session[:user_id]
#     User.find(session [:user_id])
#   end
# end

def post_ten
  @posts=Post.last(10)
  @post=@posts.reverse
end

get "/" do
  if session[:user_id]
    puts "Show current user- #{@current_user}"
  end
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d
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

  @profile =Profile.create(fname: params[:fname],lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio], user_id: @user.id)
  session[:user_id]=@user.id
  # redirect "profile_view/?id=#{@profile.id}"
  redirect "profile_view/#{@profile.id}"
end

get "/sign-in" do
  erb :sign_in_form
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
<<<<<<< HEAD
 if @user.password == params[:password]
  #  session[:user_id]=@user.id
   @profile=Profile.where(user_id: @user.id).first
   flash[:notice] = "Login successful!"
   redirect "/profile_view/?id=#{@profile.id}"
 else
   flash[:notice] = "Login failed."
   redirect "/sign-in"
=======
  if @user.password == params[:password]
    session[:user_id]=@user.id
    @profile=Profile.where(user_id: @user.id).first
    flash[:notice] = "Login successful!"
    redirect "/profile_view/#{@profile.id}"
  else
    flash[:notice] = "Login failed."
    redirect "/sign-in"
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d
  end
end

get "/sign-out" do
  session[:user_id]=nil
  redirect "/"
end

# get "/" do
#   session[:user_id]=nil
# end

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

<<<<<<< HEAD
get "/profile_view/" do
  @user = User.where(params[:post_id])
  @profile = Profile.find(params[:id])
  @post = Post.where(params[:id])

  if @user.nil?
    @post = Post.find(params[:id])
  end
=======
get "/profile_view/:id" do
  @profile = Profile.find(params[:id])
  @current_user=session[:user_id]
  puts "Show current user- #{@current_user}"
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d
  erb :profile_view
end

put "/profile_edit/:id" do
  puts "Show current user- #{@current_user}"
  @profile = Profile.find(params[:id])
  @profile.update(fname: params[:fname], lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio])
  @profile.save
<<<<<<< HEAD
  redirect "/profile_view/?id=#{@profile.id}"
end
get "/post/" do
  erb :post
end
post "/post/:id" do
    @profile_id = params['id']
    @post = Post.create(post_body: params[:post_body], post_title: params[:post_title], profile_id: @profile_id )
  redirect "/?id=#{@profile_id}"
end

# get "/show_post" do
# 	@post = Post.find(params[:id])
# 	erb :profile_view
# end

#//posts


# post '/signup' do
#   puts "THESE ARE THE PARAMS" + params.inspect
#   @userd = User.create(username: params[:username], password: params[:password], age: params[:age], name: params[:name], email: params[:email])
#   redirect '/logins'
# end

#
# get ‘/sign_out’ do
#   session[:user_id] = nil
#   redirect “/”
# end
#
# post ‘/delete’ do
#   @user = User.find(session[:user_id])
#   User.destroy(@user)
#   session[:user_id] = nil
#   redirect ‘/’
# end


# post ‘/edit’ do
#
#    @post = Post.find(params[:id])
#    @post.update(params[:content])
# end


# get “/posts/:id” do
#   @post = Post.find(params[:id])
#   @title = @post_title
#   erb :posts
# end
#
# get “/edit/:id” do
#   @post = Post.find(params[:id])
#   @title = @post_title
#   erb :profile_edit
# end
#
#
# get ‘/deletes/:id’ do
#
#
#  @post = Post.find(params[:id])
#  @post.destroy
#
#    flash[:notice] = “Successfully deleted post!”
#     redirect “/”
#
# end
#
# put “/edits/:id” do
#   @post = Post.find(params[:id])
#   @post.update(content: params[:post_body], post_title: params[:post_title])
#   redirect “/posts/#{@post.id}”
# end
=======
  # redirect "/profile_view/#{@profile.id}"
  # redirect "/profile_view"
end

# //posts

get "/post_create" do
  # @users = User.all
  # @posts= Post.all
  erb  :profile_view
end

post '/post_create' do
  if @current_user
    @post = Post.create(content: params[:post_body], post_title: params[:post_title], user_id: session[:user_id])
    # redirect '/show-post'
  # else
  #   flash[:alert] = "you need to sign in to post"
  end
  # redirect"/show-post"
end
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d
