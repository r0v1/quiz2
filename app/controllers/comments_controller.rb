class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :find_comment, only: [:destroy]

  def create
    @idea        = Idea.find params[:idea_id]
    comment_params    = params.require(:comment).permit(:body)
    @comment          = Comment.new comment_params
    @comment.idea = @idea
    if @comment.save
      redirect_to idea_path(@idea), notice: "Comment created."
    else
      render "/ideas/show"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    @comment.destroy
    redirect_to idea_path(idea), notice: "Comment deleted."
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end


end
