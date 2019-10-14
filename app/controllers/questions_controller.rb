class QuestionsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def index
    @questions = Question.are_publics().order(:message).page params[:page]
    @rights = Right.by_school_type(session[:search_type]).order(:title).page params[:page]
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.by_question(@question)
    if params['finished']
      @message=true
    end
  end

  def create
    @question = Question.new(question_params)
    @question.collage = session[:search_type]
    respond_to do |format|
      if @question.save
        return true
      end
      return false
    end
  end

  private
  def question_params
    params.require(:question).permit(:name, :email, :location, :institution, :grade, :message)
  end
end
