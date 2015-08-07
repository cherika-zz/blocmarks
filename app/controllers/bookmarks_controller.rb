class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end
  
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
  end
end
