class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_idea

    def index
      @users = @idea.liking_users
    end

    def create
      @like          = Like.new
      @like.user     = current_user
      @like.idea     = @idea
      if @like.save
        redirect_to idea_path(@idea), notice: "Liked!"
      else
        redirect_to idea_path(@idea), alert: "Can't like!"
      end
    end

    def destroy
      @like     = @idea.like_for(current_user)
      @like.destroy
      redirect_to idea_path(@idea), notice: "Un-Liked"
    end

    private

    def find_idea
      @idea = Idea.find params[:idea_id]
    end


end
