class Question < ApplicationRecord
  has_many :answers
  enum collage: [ :secundaria, :utu ]

  validates :message, :email, :name, :location, :institution, :grade, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :are_publics, ->() {
    where(is_public: true)
  }

  include PgSearch
  pg_search_scope :search_by_full_name, against: [:message],
  using: {
    tsearch: {
      prefix: true,
      negation: true
    }
  }
  after_create do
    User.by_collage(self.collage).each do |user|
      AdminMailer.with(admin: user, question: self).new_question.deliver
    end
  end

  scope :by_user_collage, ->(school_type) {
    where(collage: school_type)
  }
end
