class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum admin_type: [ :admin, :moderador ]
  enum school_type: [ :secundaria, :utu, :ambas ]


  scope :by_collage, ->(id) {
    if id != 2
      where(admin_type: "moderador", school_type: [id, 2])
    else
      where(admin_type: "moderador")
    end
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
