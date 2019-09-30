require 'ffaker'
if Rails.env.development?
  User.create(email: "tester@data.uy", password: "pass_4321", password_confirmation: 'pass_4321')

  50.times do
    Question.create({title: FFaker::AnimalUS.common_name, school_type: Question.school_types.values.sample})
  end
end
