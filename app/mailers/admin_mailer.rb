class AdminMailer < ApplicationMailer
  default from: 'contacto@derechosdeestudiantes.edu.uy'

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

  def new_complain
    @admin =  params[:admin]
    @complain = params[:complain]
    mail(to: @admin.email, subject: 'Nueva denuncia')
  end

  def new_comment
    @admin =  params[:admin]
    @answer = params[:answer]
    @url  =  admin_answer_url(@answer.id)
    mail(to: @admin.email, subject: 'Nuevo comentario')
  end

end
