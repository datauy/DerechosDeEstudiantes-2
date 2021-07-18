class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params['question_id']
    @answer.is_user = true
    @answer.is_public = false
    @answer.message = ActionView::Base.full_sanitizer.sanitize(@answer.message)
    # TODO: Agregar envío de correo a moderadores
    if @answer.save
      User.by_collage(@answer.question.collage).each do |user|
        AdminMailer.with(admin: user, answer: @answer).new_comment.deliver
      end
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
