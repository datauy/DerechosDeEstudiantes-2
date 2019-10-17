class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params['question_id']
    @answer.is_user = true
    if @answer.save
      redirect_to question_path(id: @answer.question_id, finished: true)
    else
      redirect_to question_path(@answer.question_id), notice: 'Error al crear el comentario'
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name, :email, :message)
  end
end