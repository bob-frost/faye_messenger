# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Messenger::Application.config.secret_key_base = '9ee24b8f7259c5510cb43a4a1bd201fd6248653c793ffed3debbd59da06f4302010976f88c8aef49419eeffc5560472daac60513f68dfb15c48678a9912a8f26'
