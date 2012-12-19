Given /^I logged in as a "(\w+)"$/ do |user|
  sign_in("#{user}@gentoo.org", "nopassword")
end

When /^I am on the "(.*?)" questions list page$/ do |group_name|
  g = Group.where(name: group_name).first
  visit group_questions_path(g)
end

When /^I follow "(.*?)"$/ do |question_title|
  click_link question_title
end

Then /^I should see: "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see: "(.*?)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I should see button: "(.*?)"$/ do |text|
  page.should have_button(text)
end

Then /^I should not see button: "(.*?)"$/ do |text|
  page.should_not have_button(text)
end
