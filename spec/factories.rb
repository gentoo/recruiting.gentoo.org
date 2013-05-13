FactoryGirl.define do
  factory :user do
    sequence(:email)     { |number| "test_#{number}@example.com" }
    sequence(:name)      { |number| "Test user #{number}" }
    confirmed_at         Time.now
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

  factory :mentor, parent: :user do
    workflow_state :mentor
  end
end
