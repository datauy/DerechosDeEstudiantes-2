class Question < ApplicationRecord
  enum school_type: [ :secundaria, :utu ]


  include PgSearch
  pg_search_scope :search_by_full_name, against: [:title],
  using: {
    tsearch: {
      prefix: true,
      negation: true
    }
  }


  scope :by_school_type, ->(search_type) {
    where(school_type: search_type)
  }

  scope :by_school_type_not_current, ->(search_type, question_current) {
    where(school_type: search_type).where.not(id: question_current.id).order("RANDOM()").limit(2)
  }


end
