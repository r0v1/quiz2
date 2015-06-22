class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @current_time = Time.now
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    idea_params = params.require(:idea).permit([:title, :body])
    @idea          = Idea.new(idea_params)
    if @idea.save
      redirect_to idea_path(@idea.id), notice: "Idea Created"
    else
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @like    = @idea.like_for(current_user)
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: "Idea Updated"
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path, notice: "Idea Deleted"
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    # This uses Strong Paramters feature of Rails where you must explicit by
    # default about what parameters you'd like to allow for your record
    # in this case we only want the user to enter teh title and the body
    params.require(:idea).permit([:title, :body])
  end



end
