Given /^sample question categories exist$/ do
  ["Developer Quiz", "Staffer Quiz"].inject(1) do |question_count, group_name|
    group = FactoryGirl.create :group, name: group_name
    FactoryGirl.create :question, group: group, title: "Organizational structure questions #{question_count}"
    FactoryGirl.create :question, group: group, title: "Organizational structure questions #{question_count + 1}"
    question_count + 2
  end
end

When /^I subscribe to question group "([^"]*)"$/ do |group|
  subscribe_link = page.find :xpath, "//td[text()='#{group}']/..//a[contains(text(), 'Subscribe')]"
  subscribe_link.click
end

Then /^I should be subscribed to all question groups$/ do
  User.count.should == 1
  User.last.groups.count.should == Group.count
end
