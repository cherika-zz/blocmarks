class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    # puts "INCOMING PARAMS HERE: #{params}"

    # Find the user by using params[:sender]

    @user = User.where(email: params['sender']).take
    
    # Find the topic by using params[:subject]
    @topic = Topic.where(title: params['subject']).take
    
    # Assign the url to a variable after retreiving it from params["body-plain"]
    @url = "http://#{params["body-plain"]}"

    # Check if user is nil, if so, create and save a new user
    @user = User.create(email: params[:sender], password: "#{params[:title]}_blocmarks") if @user.nil?


    # Check if the topic is nil, if so, create and save a new topic
    @topic = Topic.new(user_id: @user.id, title: params[:title]) if @topic.nil?

    # Now that you're sure you have a valid user and topic, build and save a new bookmark
    bookmark = Bookmark.build_card(url: params["stripped-text"])
    @bookmark.topic = @topic
    @bookmark.user  = @user
    @bookmark.save

    # You put the message-splitting and business
    # magic here. 

    # Assuming all went well. 
    head 200
  end
end