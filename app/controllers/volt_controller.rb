class VoltController < ApplicationController

  def volt
    render(inline: "", layout: "volt") and return unless params[:_volt_update]
    render inline: "", status: 404
  end

end
