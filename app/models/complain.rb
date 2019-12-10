class Complain < ApplicationRecord

  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


  after_create do
    if self.to_who == "UTU"
      User.for_complains_utu().each do |user|
        AdminMailer.with(admin: user, complain: self).new_complain.deliver
      end
    elsif self.to_who == "Secundaria"
      User.for_complains_secundaria().each do |user|
        AdminMailer.with(admin: user, complain: self).new_complain.deliver
      end
    end
    User.for_complains().each do |user|
      AdminMailer.with(admin: user, complain: self).new_complain.deliver
    end
  end
end
