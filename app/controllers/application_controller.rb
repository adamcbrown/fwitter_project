require './config/environment.rb'
require './app/models/tweet.rb'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweets=Tweet.ALL_MESSAGES
    erb :tweets
  end

  post '/tweets' do
    Tweet.new(params[:user], params[:message])
    redirect('/')
  end

  post '/delete-msg' do
    Tweet.ALL_MESSAGES.delete_at(params[:index].to_i)
    redirect('/')
  end
  
end