# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# SampleApp::Application.config.secret_token = '6d147aa67aa5ca84fc05b84c26b187e8d461b8b793667a1f312b4e6e9525cfb32e80b36485993d826c388cfa426aaaa3a1d1eb7778c2b125f056e5607a7d9007'

# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

#SampleApp::Application.config.secret_key_base = secure_token
SampleApp::Application.config.secret_token = secure_token
SampleApp::Application.config.secret_key_base = "c7e5387cba8c45984b9f93ace124284c4d54af2a870f08b91e7483cab421419b8c7b4b6f273b9130f0450a870ac75b8a02dca21e3ad01c05d21520f181a4acce"
