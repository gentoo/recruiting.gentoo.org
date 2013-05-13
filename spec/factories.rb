FactoryGirl.define do
  factory :user do
    email     { |number| "test_#{number}@example.com" }
    name      { |number| "Test user #{number}" }
    password  "testpassword"
  end

  factory :answer do
    association :user
    association :question
    content     { |number| "Answer number #{number}" }
  end

  factory :question do
    association :group
    title       { |number| "Question number #{number}" }
    content     { |number| "Conbtent of question number #{number}" }
  end

  factory :group do
  end
end
