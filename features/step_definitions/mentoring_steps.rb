Given /^sample recruits exist$/ do
  User.count.should == 1
  me = User.last
  candidate = FactoryGirl.create :candidate
  recruit1 = FactoryGirl.create :user
  recruit2 = FactoryGirl.create :user, groups: Group.all
  recruit3 = FactoryGirl.create :user, groups: Group.all
  step "sample question categories exist"
  Question.all.each do |question|
    answer1 = Factory :answer, user: recruit1, question: question
    answer2 = Factory :answer, user: recruit2, question: question
    me.accept!(answer2)
  end
  me.sponsees << [recruit1, recruit2, recruit3]
  me.save!
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end

When /^press "(.*?)"$/ do |button|
  click_button(button)
end
