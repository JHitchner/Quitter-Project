require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
set :sessions, true

# def current_user
#   if session[:user_id]
#     User.find(session[:user_id])
#   end
# end

get "/sign-up" do
  erb :sign_up_form
end

post "/sign-up" do
  @user=User.create(
    username: params[:username],
    password: params[:password]
  )
  @profile =Profile.create(fname: params[:fname],lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio], user_id: @user.id)
  redirect "profile_view/?id=#{@profile.id}"

end

get "/sign-in" do
  erb :sign_in_form
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
 if @user.password == params[:password]
  #  session[:user_id]=@user.id
   @profile=Profile.where(user_id: @user.id).first
   flash[:notice] = "Login successful!"
   redirect "/profile_view/?id=#{@profile.id}"
 else
   flash[:notice] = "Login failed."
   redirect "/sign-in"
  end
end

get "/" do
  session[:user_id]=nil
end

get "/delete_account" do
  erb :account_delete
  session[:user_id]=nil
end

post "/delete_acount" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    @user.delete()
    flash[:notice] = "Account Deleted!"
    redirect "/"
  else
    puts "failed to delete"
  end
end

get "/profile_view/" do
  @profile = Profile.find(params['id'])
  erb :profile_view
end


put "/profile_edit/:id" do
  session[:user_id]
  @profile = Profile.find(params[:id])
  @profile.update(fname: params[:fname], lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio])
  @profile.save
  redirect "/profile_view/?id=#{@profile.id}"
end

#//posts

get "/show-post" do
  @users = User.all
  @posts= Post.all
  erb  :profile_view
end

# post '/signup' do
#   puts "THESE ARE THE PARAMS" + params.inspect
#   @userd = User.create(username: params[:username], password: params[:password], age: params[:age], name: params[:name], email: params[:email])
#   redirect '/logins'
# end

post '/posts' do

  if session[:user_id]
    @post = Post.create(content: params[:postcontent], post_title: params[:post_title], user_id: session[:user_id])
    redirect '/show-post'
  else
    flash[:alert] = "you need to sign in to post"
  end
  redirect"/show-post"

 end
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
#   @post.update(content: params[:postcontent], post_title: params[:post_title])
#   redirect “/posts/#{@post.id}”
# end
