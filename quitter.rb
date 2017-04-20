require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "bundler/setup"
require "./models"

set :database, "sqlite3:quitterbase.sqlite3"
set :sessions, true

get "/sign-up" do
  erb :sign_up_form
end

post "/sign-up" do
  @user=User.create(
    username: params[:username],
    password: params[:password]
  )
  # @user = User.find(session[@user.id])
  # redirect "/profile_new/#{user}"
  redirect "/profile_new?user_id=#{@user.id}"
end

get "/sign-in" do
  erb :sign_in_form
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    session[:user_id]=@user.id
    @profile=Profile.where(user_id: @user).first
    if @profile.user_id == "nil"
      @profile.user_id=@user.id
    end
    flash[:notice] = "Login successful!"
    redirect "/"
  else
    flash[:alert] = "Login failed."
    redirect "/sign-in"
  end
end

def current_user
  if session[:user_id]
    User.find(session[:user_id])
  end
end

get "/sign-out" do
  session[:user_id]=nil
  redirect "/"
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

get "/profile_view/:id" do
	@profile = Profile.find(params['id'])
  erb :profile_view
end

get "/profile_new" do
  erb :profile_create
end

post "/profile_new" do
  # puts "params", params.inspect
  @profile =Profile.create(email:params[:email], bday:params[:bday], bio:params[:bio])
  # redirect "/profile_view/"+ @profile.id.to_s
  redirect "/profile_view/#{@profile.id}"
end

get "/profile_delete" do
  erb :profile_delete
end
