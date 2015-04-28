module Wysiwyg
  class MainController < Volt::ModelController
    attr_reader :quill

    def index_ready
      @updating_attribute = false
      %x{
        var quill = new Quill('.quill-editor', {
          modules: {
            'toolbar': {
              container: '.toolbar-container'
            },
            authorship: {
              authorId: '#{attrs.user_id}'
            },
            'link-tooltip': true,
            'image-tooltip': true
          },
          styles: false,
          theme: 'snow'
        });
        #{@quill} = quill

        quill.on('text-change', function(delta, source){
          if (!self.updating_editor) {
            console.log('text change' + delta + 'source:' + source );
            #{@updating_attribute = true }
            #{new_text = nil ; puts 'updating'}
            new_text = quill.getHTML();
            #{ attrs.text = new_text }
            setImmediate(function(){ #{ @updating_attribute = false } });
          }
        });
      }

      @computation = -> { update_text(attrs.text) }.watch!
    end

    def before_index_remove
      @computation.stop
    end

    def update_text(new_text)
      unless @updating_attribute
        @updating_editor = true
        puts 'updating text'
         `#{quill}.setHTML(#{new_text || ''})`
        @updating_editor = false
      end
    end

  end
end
