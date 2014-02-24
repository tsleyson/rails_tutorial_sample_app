class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  before_save { self.email = email.downcase }
  before_create :create_remember_token  # Method ref style of callback setting; preferred.

  has_secure_password

  def User.new_remember_token
    # Generate random 16-char string from an alphabet of 64 chars.
    # For saving as user cookie to verify a session.
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    # Encrypt remember_token with SHA1 to protect logged-in
    # users from session hijacking. SHA1 faster than Bcrypt.
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      # Encrypt a new 16-char string.
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
