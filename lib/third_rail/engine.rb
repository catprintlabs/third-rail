require 'volt/server'
module ThirdRail
  class Engine < ::Rails::Engine
    isolate_namespace ThirdRail
    # config.volt_path = (defined? VOLT_PATH) ? VOLT_PATH : '/app/voltage'

    #
    dir = __FILE__.rpartition('/').first
    ::VOLT_PATH = File.expand_path("#{dir}/../volt_wrapper")
    server = Volt::Server.new(::VOLT_PATH).app
    config.volt_server = server
    config.middleware.delete Rack::Lock
  end
end
