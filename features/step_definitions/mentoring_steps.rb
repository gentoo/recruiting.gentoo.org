Given /^sample recruits exist$/ do
  User.count.should == 1
  me = User.last
  candidate = FactoryGirl.create :candidate
  recruit1 = FactoryGirl.create :user
  recruit2 = FactoryGirl.create :user, groups: Group.all
  recruit3 = FactoryGirl.create :user, groups: Group.all
  step "sample question categories exist"
  Question.all.each do |question|
    answer1 = FactoryGirl.create :answer, user: recruit1, question: question
    answer2 = FactoryGirl.create :answer, user: recruit2, question: question
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

When /^I follow first candidate name$/ do
  step %{follow "#{User.candidates.first.name}"}
end

Then /^I should( not)? mentor all other users$/ do |negation|
  me = User.find_by(workflow_state: 'mentor')
  expect((me.sponsees.count == User.count - 1) ^ negation).to be(true)
end

Then /^I should( not)? see link "([^"]*)"$/ do |negation, text|
  if negation
    page.should have_no_xpath("//a[contains(text(), '#{text}')]")
  else
    page.should have_xpath("//a[contains(text(), '#{text}')]")
  end
end
