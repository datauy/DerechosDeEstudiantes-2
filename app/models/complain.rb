class Complain < ApplicationRecord
  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
