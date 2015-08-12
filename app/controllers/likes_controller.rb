class LikesController < ApplicationController
  def create
    bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: bookmark)

    authorize like

    if like.save
      # Add code to generate a success flash and redirect to @bookmark
      flash[:notice] = "Like was saved successfully."
      redirect_to request.referer
    else
      # Add code to generate a failure flash and redirect to @bookmark
      flash[:notice] = "There was an error. Please try again."
      redirect_to request.referer
    end
  end

  def destroy
  # Get the bookmark from the params
  # Find the current user's like with the ID in the params
    bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    authorize like

    if like.destroy
      # Flash success and redirect to @bookmark
      flash[:notice] = "Like was saved successfully."
      redirect_to request.referer
    else
      # Flash error and redirect to @bookmark
      flash[:notice] = "There was an error. Please try again."
      redirect_to request.referer
    end
  end
end
