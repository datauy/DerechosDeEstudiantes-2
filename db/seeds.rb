require 'ffaker'
#if Rails.env.development?
  #User.create(email: "tester@data.uy", password: "pass_4321", password_confirmation: 'pass_4321')

locations=['CANELONES', 'CERRO LARGO', 'COLONIA', 'DURAZNO', 'FLORES', 'FLORIDA', 'LAVALLEJA', 'LIMITE CONTESTADO', 'MALDONADO']
institutions=['ARTIGAS DEPTAL', 'ARTIGAS N 2', 'ARTIGAS N 3 - MTRO. VALERIANO RENART', 'ARTIGAS N 4', 'MONTEVIDEO N34 -   RAFAELA VILLAGRAN DE ARTIGAS', 'MONTEVIDEO N4-  JUAN ZORRILLA DE SAN MARTIN', 'ARTIGAS N 5 (PINTADITO)']
grades = [1,2,3]
25.times do
  Question.create({
    location: locations.sample,
    institution: institutions.sample,
    grade:  grades.sample,
    message: FFaker::LoremIE.question})
end

institutions=['CECAP - ARTIGAS', 'ESCUELA TECNICA ARTIGAS', 'ESCUELA AGRARIA ARTIGAS', 'C. E. C. SAN MARTIN']
grades = [1,2,3,4,5,6]
25.times do
  Question.create({
    location: locations.sample,
    institution: institutions.sample,
    grade:  grades.sample,
    message: FFaker::LoremIE.question,
    email: FFaker::Internet.email,
    name: FFaker::NameMX.full_name
    })
end

50.times do
  Right.create({
    title: FFaker::LoremIE.question,
    school_type: Right.school_types.values.sample,
    description: '<ul><li>La Asamblea Nacional de Estudiantes de Enseñanza Secundaria.</li><li>Las Mesas Representativas de Estudiantes.</li><li>Los Consejos de Participación Liceal.</li></ul><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus convallis tincidunt ante, scelerisque molestie ante condimentum a. Aenean consectetur quis quam eget interdum. Proin ac tellus sed nulla bibendum condimentum. Donec non mi sem. Nunc lacus leo, scelerisque sed scelerisque accumsan, tempor et diam. Etiam scelerisque nec lectus vulputate fermentum. Etiam nisi ligula, ultricies eu tellus et, commodo tristique risus. Sed ultricies blandit finibus. Phasellus cursus leo felis, efficitur lobortis velit viverra et. Mauris dolor nulla, condimentum vel libero sed, ornare pulvinar lectus. Fusce consectetur at ante eu aliquet.</p>',
    tag_one: FFaker::AddressMX.state_abbr,
    tag_two: FFaker::AddressMX.state_abbr,
    tag_three: FFaker::AddressMX.state_abbr,
    tag_four: FFaker::AddressMX.state_abbr})
end
#end