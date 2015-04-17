# Opal::Processor.source_map_enabled = true
Volt.configure do |config|
  # Setup your global app config here.

  # Your app secret is used for signing things like the user cookie so it can't
  # be tampered with.  A random value is generated on new projects that will work
  # without the need to customize.  Make sure this value doesn't leave your server.
  #
  # For added security we reccomend moving the app secret into an enviromnet.  You can
  # setup that like so:
  #
  # config.app_secret = ENV['APP_SECRET']
  #
  config.app_secret = 'X2dhOHj9C22HFYhpUawozBDy0JGy-MvRXgrG-Q5ZqP_Ocp0YvBFML-2Iny-Tur1fxZk'

  # Data updates from the client come in via Tasks.  The task dispatcher logs all calls to tasks.
  # By default hashes in the arguments can be filtered based on keys.  So any hash with a key of
  # password will be filtered.  You can add more fields to filter below:
  config.filter_keys = [:password]

  # Database config all start with db_ and can be set either in the config
  # file or with an environment variable (DB_NAME for example).

  # config.db_driver = 'mongo'
  # config.db_name = (config.app_name + '_' + Volt.env.to_s)
  # config.db_host = 'localhost'
  # config.db_port = 27017

  # Compression options

  # If you are not running behind something like nginx in production, you can
  # have rack deflate all files.
  # config.deflate = true

  # Public configurations
  # Anything under config.public will be sent to the client as well as the server,
  # so be sure no private data ends up under public

  # Use username instead of email as the login
  # config.public.auth.use_username = true

end