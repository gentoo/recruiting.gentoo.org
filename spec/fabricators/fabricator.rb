Fabricator(:user) do |f|
  name Faker::Name.name
  password Faker::Internet.password(8)
  email Faker::Internet.free_email
  answers(count:100)
end

Fabricator(:answer) do |f|
  content Faker::Lorem.sentence
  question
end

Fabricator(:question) do |f|
  title Faker::Name.title
  content Faker::Lorem.sentence
  group
end

Fabricator(:group) do |f|
  name Faker::Name.name
end
