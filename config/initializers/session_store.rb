# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_developer.anywhere.cn_session',
  :secret      => '31843da8283dba0ec8bd8b8b5cd4fe157732c2b761c6d14c9a89b414c4bb844ec460b27a4cb79ebc7ce8e50d17ecd4e3b4172a15f335521ce9921982189aa4e2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
