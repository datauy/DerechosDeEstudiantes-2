if Rails.env.development?
  User.create(email: "tester@data.uy", password: "pass_1234", password_confirmation: 'pass_1234')
end
