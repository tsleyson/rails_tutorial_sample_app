module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    # Rails lets us treat cookies like hashes. Under the hood, calling permanent actually sets the expiration time to 20.years.from_now.
    user.update_attribute :remember_token, User.encrypt(remember_token)
    self.current_user = user  # Not yet implemented. Not necessary now because we immediately redirect users upon sign-in, but good to have in case we don't have
  end

  def current_user= (user)
    @current_user = user
  end

  def current_user
    # Idiomatic in Ruby to name setters 'field=' and getters 'field'.
    # Rails blows away the value of current_user between pages, so we have to
    # retrieve it by looking up the user's current remember token.
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
    # No find_by(rt:) in Rails 3.
    # ||= sets @current_user if @current_user is undefined.
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute :remember_token, User.encrypt(User.new_remember_token)
    cookies.delete :remember_token
    self.current_user = nil
  end

  # For some reason doesn't work unless these current_user methods are in
  # spec/utilities.rb, and I really don't feel like figuring out why.
  # So they are duplicated here.
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
