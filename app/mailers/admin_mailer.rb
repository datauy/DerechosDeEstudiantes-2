class AdminMailer < ApplicationMailer
  default from: 'hola@derechos_de_estudiantes.uy'

  def send_answer
    @answer = params[:answer]
    @url  = params[:url]
    mail(to: @answer.question.email, subject: 'Nuestra respuesta')
  end

  def new_question
    @admin =  params[:admin]
    @question = params[:question]
    @url  =  admin_question_url(@question.id)
    mail(to: @admin.email, subject: 'Nueva pregunta')
  end

  def new_doubt
    @admin =  params[:admin]
    @doubt = params[:doubt]
    @url  = admin_right_url(@doubt.right.id)
    mail(to: @admin.email, subject: 'Nueva duda de un derecho')
  end
end
