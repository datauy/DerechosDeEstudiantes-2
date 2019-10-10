class Answer < ApplicationRecord
  belongs_to :question

  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :by_question, ->(question) {
    where(question_id: question)
  }

end
