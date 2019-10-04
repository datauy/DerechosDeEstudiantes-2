class QuestionsController < ApplicationController
  before_action :get_establecimientos_json

  def index
    @questions = Question.by_school_type(session[:search_type]).order(:title).page params[:page]
  end

  def show
    @question = Question.find(params[:id])
    @questions = Question.by_school_type_not_current(session[:search_type], @question )
  end
end