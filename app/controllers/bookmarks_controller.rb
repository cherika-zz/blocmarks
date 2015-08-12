class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
    authorize @bookmarks
  end

  def new
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    # nested hash
    @bookmark = @topic.bookmarks.build(params.require(:bookmark).permit(:url))
    @bookmark.user = current_user

    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to @topic
    else
      flash[:notice] = "There was an error saving your bookmark. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @topic.user = current_user
    @bookmarks = @topic.bookmarks

    @bookmark = @topic.bookmarks.find(params[:id])
    authorize @bookmark
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])

    authorize @bookmark

    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      flash[:notice] = "Bookmark was updated successfully."
      redirect_to @topic
    else
      flash[:notice] = "There was an error saving your request."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
    authorize @bookmark
    # @bookmark.topic = @topic
    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted successfully."
      redirect_to @topic
    else
      flash[:notice] = "There was an error. Please try again."
      render :new
    end
  end
end
