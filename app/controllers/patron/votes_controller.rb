class Patron::VotesController < PatronController

  def new

    @placement = Placement.find(params[:placement_id])
    @vote = @placement.votes.new

  end

  def create

    vote = Placement.find(params[:placement_id]).votes.new(params[:vote])
    vote.save!

  end

end