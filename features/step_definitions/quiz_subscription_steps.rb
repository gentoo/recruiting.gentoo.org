Given /^sample question categories exist$/ do
  [ 'first', 'second'].each do |group_name|
    group = FactoryGirl.create :group, name: group_name
    FactoryGirl.create_list :question, 2, group: group
  end
end

When /^I subscribe to question group "([^"]*)"$/ do |group|
  subscribe_link = page.find :xpath, "//td[text()='#{group}']/..//a[contains(text(), 'subscribe')]"
  binding.pry
end

Then /^I should be subscribed to all question groups$/ do
  User.count.should == 1
end
