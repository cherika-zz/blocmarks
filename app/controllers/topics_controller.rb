class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(params.require(:topic).permit(:title))
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def edit
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "Topic was successfully deleted."
      redirect_to topics_path
    else
      flash[:error] = "There was an error processing your request. Please try again"
      render :show
    end
  end
end
