class Complain < ApplicationRecord

  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


  after_create do
    User.for_complains().each do |user|
      AdminMailer.with(admin: user, complain: self).new_complain.deliver
    end
  end

end
