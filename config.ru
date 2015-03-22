# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

console = ActiveSupport::Logger.new($stdout)
console.formatter = Rails.logger.formatter
console.level = Rails.logger.level

Rails.logger.extend(ActiveSupport::Logger.broadcast(console))

run Rails.application
puts 'after starting rails application'
#require 'volt/server'
#run Volt::Server.new.app