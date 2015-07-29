class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end
end
