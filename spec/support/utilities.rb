# Rspec utilties for use in testing.

def full_title(page_title)
  base_title = 'Ruby on Rails Tutorial Sample App'
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # Note: the tutorial uses User.digest. For some reason I named the
    # method User.encrypt.
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign in'
  end
end

def current_user
  remember_token = User.digest(cookies[:remember_token])
  @current_user ||= User.find_by(remember_token: remember_token)
end

def current_user?(user)
  user == current_user
end
