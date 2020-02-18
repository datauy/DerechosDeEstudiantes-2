class QuestionsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def index
    if params[:search]
      @questions = Question.are_publics().search_by_full_name(params[:search]).with_pg_search_highlight.page params[:page]
      @rights = Right.by_school_type(session[:search_type]).search_by_full_title(params[:search]).with_pg_search_highlight.page params[:page]
    else
      @questions = Question.are_publics().order(:message).page params[:page]
      @rights = Right.by_school_type(session[:search_type]).order(:title).page params[:page]
    end
    respond_to do |format|
      format.js{
        render :template => "questions/index.js.haml", :layout => false
      }
      format.html{}
    end
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

  def update
    @question = Question.find(params[:id])
    @question.count_help = @question.count_help + 1
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
