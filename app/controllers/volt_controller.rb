class VoltController < ApplicationController
  
  def volt
    render(inline: "", layout: "application") and return unless params[:_volt_update]
    render inline: "", status: 404
  end
  
end
