class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || @user.admin?
      redirect_to :back, :alert => "접근권한이 업습니다."
    end
  end

  def my_story
    @user = User.find(params[:id])
    @stories = @user.stories
  end

  def reporter_profile
    @reporters = User.where(role:'reporter').all
    @reporters += User.where(role:'team_leader').all
  end

end
