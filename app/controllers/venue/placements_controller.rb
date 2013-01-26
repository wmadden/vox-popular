class Venue::PlacementsController < VenueController

  def update

    @placement = Placement.find(params[:placement_id])
    @placement.update_attributes(params[:placement])

  end

end