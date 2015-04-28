require 'opal'
module ThirdRail
  module ApplicationHelper

    def volt_layout
      script_blocks = @view_flow.content.collect do |key, html|
        "<script type='text/rails_content' id='rails_content_#{key}'>\n#{html}\n</script>"
      end

      if params[:_volt_update]
        script_blocks.join("\n").html_safe
      else
        script_blocks += Volt::Server.index_files.javascript_files.collect do |javascript_file|
          "<script src='#{javascript_file}'></script>"
        end

        script_blocks += Volt::Server.index_files.css_files.collect do |css_file|
          "<link href='#{css_file}' media='all' rel='stylesheet' type='text/css' />"
        end

        [
          "<!DOCTYPE html>",
          "<html>",
          "<head>",
          "<meta charset='UTF-8' />",
          script_blocks.join("\n"),
          "</head>",
          "<body>",
          "</body>",
          "</html>"
        ].join("\n").html_safe

      end
    end

    def render_component(component_name)
      opal_code = Volt::ComponentCode.new(component_name, $volt_server.component_paths, false).code
      js_code   = "$( document ).ready(function(){ #{Opal.compile(opal_code)}})"
      content_for :footer do
        javascript_tag(js_code.html_safe)
      end

      "<div class='volt-rails-component' data-component='#{component_name}' />".html_safe
    end

  end
end
