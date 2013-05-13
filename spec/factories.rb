FactoryGirl.define do
  factory :user do
    email     { |number| "test_#{number}@example.com" }
    name      { |number| "Test user #{number}" }
    password  "testpassword"
  end

  factory :answer do
    association :user
    association :question
    sequence(:content) { |n| "Answer number #{n}" }
  end

  factory :question do
    association :group
    sequence(:title)  { |n| "Question number #{n}" }
    sequence(:content) { |n| "Conbtent of question number #{n}" }
  end

  factory :group

  factory :candidate, parent: :user
end
