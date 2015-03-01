require './config/environment.rb'
require './app/models/tweet.rb'
require './app/models/user.rb'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "My session secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweets=Tweet.all

    session[:login_fail] = false

    user_id=session[:user_id]

    if user_id!=nil
      @user=User.find(user_id)
    else
      @user=nil
    end

    erb :tweets
  end

  get '/login' do
    @login_fail=session[:login_fail]
    if @login_fail==nil
      @login_fail=false
    end

    erb :login
  end

  post '/create_user' do
    user=User.new(:username=>params[:username], :email=>params[:email],
                  :profile_img_link=>params[:profile_img_link])
    user.save
    session[:user_id] = user.id
    redirect('/')
  end

  post '/login_user' do
    user=User.find_by(:email=>params[:email])
    if user!=nil
      session[:user_id] = user.id
      redirect('/')
    else
      session[:user_id] = nil
      session[:login_fail] = true
      redirect('/login')
    end
  end

  post '/logout' do
    session[:user_id]=nil
    redirect('/')
  end

  post '/tweets' do
    id=session[:user_id]
    if id!=0
      user=User.find(id)
      user.tweets<<Tweet.new(:message=>params[:message])
    end
    redirect('/')
  end

  post '/delete-msg' do
    Tweet.delete(params[:index].to_i)
    redirect('/')
  end
  
end