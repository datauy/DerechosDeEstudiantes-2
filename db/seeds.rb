require 'ffaker'
if Rails.env.development?
  #User.create(email: "tester@data.uy", password: "pass_4321", password_confirmation: 'pass_4321')

  locations=['CANELONES', 'CERRO LARGO', 'COLONIA', 'DURAZNO', 'FLORES', 'FLORIDA', 'LAVALLEJA', 'LIMITE CONTESTADO', 'MALDONADO']
  institutions=['ARTIGAS DEPTAL', 'ARTIGAS N 2', 'ARTIGAS N 3 - MTRO. VALERIANO RENART', 'ARTIGAS N 4', 'MONTEVIDEO N34 -   RAFAELA VILLAGRAN DE ARTIGAS', 'MONTEVIDEO N4-  JUAN ZORRILLA DE SAN MARTIN', 'ARTIGAS N 5 (PINTADITO)']
  grades = [1,2,3]
  25.times do
    Question.create({location: locations.sample, institution: institutions.sample, grade:  grades.sample, message: FFaker::LoremIE.question})
  end

  institutions=['CECAP - ARTIGAS', 'ESCUELA TECNICA ARTIGAS', 'ESCUELA AGRARIA ARTIGAS', 'C. E. C. SAN MARTIN']
  grades = [1,2,3,4,5,6]
  25.times do
    Question.create({location: locations.sample, institution: institutions.sample, grade:  grades.sample, message: FFaker::LoremIE.question})
  end

  50.times do
    Right.create({title: FFaker::LoremIE.question, school_type: Right.school_types.values.sample})
  end
end
