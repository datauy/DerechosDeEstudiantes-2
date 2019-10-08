class Answer < ApplicationRecord
  belongs_to :question

  scope :by_question, ->(question) {
    where(question_id: question)
  }

end
