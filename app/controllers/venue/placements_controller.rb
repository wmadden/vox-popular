class PlacementsController < ApplicationController

  def update

    @placement = Placement.find(params[:placement_id])
    @placement.update_attributes(params[:placement])

  end

end