class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum admin_type: [ :admin, :moderador ]
  enum school_type: [ :secundaria, :utu ]


  scope :by_collage, ->(id) {
    where(admin_type: "moderador", school_type: id)
  }

  scope :for_complains, ->() {
    where(for_complain: true, school_type: nil)
  }

  scope :for_complains_utu, ->() {
    where(for_complain: true, school_type: "utu")
  }

  scope :for_complains_secundaria, ->() {
    where(for_complain: true, school_type: "secundaria")
  }

end
