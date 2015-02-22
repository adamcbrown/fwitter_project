require './config/environment.rb'
require './app/models/tweet.rb'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweets=Tweet.all
    erb :tweets
  end

  post '/tweets' do
    tweet=Tweet.new(:user=>params[:user], :message=>params[:message])
    tweet.save
    redirect('/')
  end

  post '/delete-msg' do
    Tweet.delete(params[:index].to_i)
    redirect('/')
  end
  
end