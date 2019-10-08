class QuestionsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def index
    @questions = Question.all.order(:message).page params[:page]
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.by_question(@question)
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        return true
      end
    end
  end

  private
  def question_params
    params.require(:question).permit(:location, :institution, :grade, :message)
  end
end
