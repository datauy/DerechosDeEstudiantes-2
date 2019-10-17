class Doubt < ApplicationRecord
  belongs_to :right

  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create do
    User.by_collage(self.right.school_type).each do |user|
      AdminMailer.with(admin: user, doubt: self).new_doubt.deliver
    end
  end
end
