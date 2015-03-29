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
  end
end
