module DateSelect
  class MainController < Volt::ModelController

    model :page

    def index_ready
      dp = Element.find('.volt-date-picker')
      `dp.datepicker()`
      nil
    end

  end
end

