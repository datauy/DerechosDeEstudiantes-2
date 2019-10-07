class Question < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:message],
  using: {
    tsearch: {
      prefix: true,
      negation: true
    }
  }
end
