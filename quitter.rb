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
    @profile=Profile.where(user_id: @user.id).first
    if !@profile.nil?
      @user.update(profile_id: @profile.id)
    end
    flash[:notice] = "Login successful!"
    redirect "/profile_view"
  else
    flash[:notice] = "Login failed."
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
  @user.profile_id = @profile.id

  erb :profile_view
end

get "/profile_new?:id" do

  erb :profile_create
end

post "/profile_new?:id" do
  @user_id = session[:user_id]
  @profile =Profile.create(fname: params[:fname],lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio], user_id: @user_id)
  redirect "profile_view/#{@profile.id}"
end

put "/profile_edit/:id" do
  session[:user_id]
  @profile = Profile.find(params[:id])
  @profile.update(fname: params[:fname], lname: params[:lname], email:params[:email], bday:params[:bday], bio:params[:bio])
  @profile.save
  redirect "/profile_view/#{@profile.id}"

end
