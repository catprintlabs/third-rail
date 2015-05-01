require 'volt/server'
require 'volt/boot'
require 'volt/server/websocket/rack_server_adaptor'
require_relative 'build_dependencies'
module ThirdRail
  class Engine < ::Rails::Engine
    isolate_namespace ThirdRail
    # config.volt_path = (defined? VOLT_PATH) ? VOLT_PATH : '/app/voltage'

    #
    dir = __FILE__.rpartition('/').first
    volt_path = File.expand_path("#{dir}/../volt_wrapper")
    server = Volt::Server.new(volt_path, false, 'app/components')
    config.volt_server = server.app
    booted = Volt.boot(volt_path, ['app/components'])
    opal_files             = Volt::OpalFiles.new(Rack::Builder.new, volt_path, booted.component_paths)
    index_files            = Volt::IndexFiles.new(nil, booted.component_paths, opal_files)
    $volt_javascript_files = index_files.javascript_files
    $volt_css_files        = index_files.css_files

    config.middleware.delete Rack::Lock
  end
end

#TEMPORARY HACK for weirdness/bug in Rack that may be in response to another bug
#based on comment on line 26 of rack-1.6.0/lib/rack/body_proxy.rb
module Rack
  class BodyProxy
    def each(*args, &block)
      @body.is_a?(String) ?  block.call(@body) : @body.each(*args, &block)
    end
  end
end