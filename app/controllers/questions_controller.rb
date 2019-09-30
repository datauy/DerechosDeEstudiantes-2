class QuestionsController < ApplicationController
  def index
    @users = User.order(:email).page params[:page]

  end

  def show
    @users = User.order(:email).page params[:page]
  end
end