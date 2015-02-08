class Tweet
  attr_reader :user, :message

  ALL_MESSAGES=[]

  def initialize(user, message)
    @user=user
    @message=message

    ALL_MESSAGES << self
  end

  def self.ALL_MESSAGES
    ALL_MESSAGES
  end
  
end