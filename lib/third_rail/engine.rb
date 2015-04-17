require 'volt/server'
require 'volt_extensions/model_controller'
module ThirdRail
  class Engine < ::Rails::Engine
    isolate_namespace ThirdRail
    config.volt_path = (defined? VOLT_PATH) ? VOLT_PATH : '/app/voltage'

    ::VOLT_PATH = config.volt_path
    server = Volt::Server.new(File.expand_path("#{Dir.pwd}/#{config.volt_path}")).app
    config.volt_server = server
    config.middleware.delete Rack::Lock
  end
end
