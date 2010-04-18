# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_clustter_session',
  :secret      => '54b640fd9ec334043798918937d6596d282215efc88a74c88b390d28245b917a343b4591cff9c7c6d45f25d1e34e52040997b52e9bc78c4c0dc88e0a9db9a16a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
