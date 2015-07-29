class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    # puts "INCOMING PARAMS HERE: #{params}"

    # Find the user by using params[:sender]

    @user = User.where(email: params['sender']).take
    # Check if user is nil, if so, create and save a new user
    @user = User.create(email: params[:sender], password: "#{params['Subject']}_blocmarks") if @user.nil?
    
    # Find the topic by using params[:subject]
    @topic = Topic.where(title: params['Subject']).take
    

    # Check if the topic is nil, if so, create and save a new topic
    @topic = Topic.new(user_id: @user.id, title: params['Subject']) if @topic.nil?

    # Now that you're sure you have a valid user and topic, build and save a new bookmark
    @bookmark = Bookmark.new(url: params["stripped-text"])
    @bookmark.topic = @topic
    @bookmark.user  = @user
    @bookmark.save

    # You put the message-splitting and business
    # magic here. 

    # Assuming all went well. 
    head 200
  end
end