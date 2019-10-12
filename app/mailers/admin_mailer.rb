class AdminMailer < ApplicationMailer
  default from: 'hola@derechos_de_estudiantes.uy'

  def send_answer
    @answer = params[:answer]
    @url  = params[:url]
    mail(to: @answer.question.email, subject: 'Nuestra respuesta')
  end
end
