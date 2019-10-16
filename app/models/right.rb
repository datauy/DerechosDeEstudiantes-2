class Right < ApplicationRecord
  has_many :doubts
  enum school_type: [ :secundaria, :utu , :ambas]

  include PgSearch
  pg_search_scope :search_by_full_title,
    against: [:title, :tag_one, :tag_two, :tag_three, :tag_four],
    using: {
      tsearch: {
        prefix: true,
        negation: true
      }
    }


  scope :by_school_type, ->(search_type) {
    school_type_relation = where(school_type: search_type).pluck(:id)
    both_relation = where(school_type: "ambas").pluck(:id)
    return where(id: (school_type_relation + both_relation))
  }

  scope :by_school_type_not_current, ->(search_type, question_current) {
    where(school_type: search_type).where.not(id: question_current.id).order("RANDOM()").limit(2)
  }


end


