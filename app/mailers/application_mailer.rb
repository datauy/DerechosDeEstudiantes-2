class ApplicationMailer < ActionMailer::Base
  default from: 'contacto@derechosdeestudiantes.edu.uy', host: 'derechosdeestudiantes.edu.uy'
  layout 'mailer'
end
