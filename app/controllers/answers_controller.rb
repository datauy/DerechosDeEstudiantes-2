class AnswersController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params['question_id']
    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(@answer.question_id), notice: 'Error al crear el comentario'
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name, :email, :message)
  end
end