 module Volt
  class ModelController
    class << self
      def start_watcher(&block)
        puts 'inside start_watcher'
        block.watch! unless @watcher_running
        @watcher_running = true
      end
    end

    def initialize
      puts 'initializing main'
      super
      puts 'after super'
      self.class.start_watcher do
        puts 'in here'
        unless page._last_valid_path
          puts 'first time in start watcher'
          page._last_valid_path = url.path
          page._rails_content = `$(document)`
        end
        url_path = url.path # we don't want it changing while we are waiting
        if page._last_valid_path != url.path
          puts 'url.path changed'
          HTTP.get("#{url_path}?_volt_update=true") do |response|
            if response.ok?
              page._last_valid_path = url_path
              puts "response okay, page changed!"
              body = response.body
              page._rails_content = `$('<newscripts>').append($.parseHTML(body, true))`
              puts "now @rails_content = #{page._rails_content}"
            end
            puts "last valid path now = #{page._last_valid_path}"
          end
        end
      end
    end

    def content_for(tag = :layout)
      the_rails_content = page._rails_content
      tag = "#rails_content_#{tag}"
      # Element.find(tag, the_rails_content)
      raw `$(#{tag}, #{the_rails_content})`.html
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._controller and params._action values.
    def main_path
      params._controller || 'main' + '/' + (params._action || 'index')
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end