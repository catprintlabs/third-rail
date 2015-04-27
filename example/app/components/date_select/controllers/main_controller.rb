
class DateSelect
  class MainController < Volt::ModelController

    def initialize
    end

    def index
      Document.ready? do
        dp = Element.find('.volt-date-picker')
        `dp.datepicker()`
        nil
      end
    end

    def select
    end

  end
end

