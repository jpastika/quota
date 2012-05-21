include ApplicationHelper


def sign_in(member)
  visit signin_path
  fill_in "Email",    with: member.user.email
  fill_in "Password", with: member.user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = member.remember_token
end