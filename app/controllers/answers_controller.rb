class AnswersController < ApplicationController
  def index
    @users = User.order(:email).page params[:page]
  end
end