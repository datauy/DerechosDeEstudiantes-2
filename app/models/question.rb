class Question < ApplicationRecord
  has_many :answers

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
end
