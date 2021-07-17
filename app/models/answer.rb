class Answer < ApplicationRecord
  belongs_to :question
  accepts_nested_attributes_for :question, update_only: true

  validates :message, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :by_question, ->(question) {
    where(question_id: question, is_public: true)
  }

end
