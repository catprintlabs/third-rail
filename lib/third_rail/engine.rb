require 'volt/server'
module ThirdRail
  class Engine < ::Rails::Engine
    isolate_namespace ThirdRail
    config.volt_server = Volt::Server.new(File.expand_path("#{Dir.pwd}/voltage")).app
  end
end
