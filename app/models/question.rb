class Question < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:title],
  using: {
    tsearch: {
      prefix: true,
      negation: true,
      highlight: {
        start_sel: '',
        stop_sel: '',
      }
    }
  }
end
