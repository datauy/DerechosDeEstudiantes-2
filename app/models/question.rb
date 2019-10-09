class Question < ApplicationRecord
  has_many :answers

  validates :message, :email,:name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


  include PgSearch
  pg_search_scope :search_by_full_name, against: [:message],
  using: {
    tsearch: {
      prefix: true,
      negation: true
    }
  }
end
