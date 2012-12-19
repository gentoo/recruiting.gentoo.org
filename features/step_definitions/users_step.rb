def sign_in(user, pass)
  visit '/users/sign_in'
  fill_in "user_email", :with => user
  fill_in "user_password", :with => pass
  click_button "Sign in"
end


