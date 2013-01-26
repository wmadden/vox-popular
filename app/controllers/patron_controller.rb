require 'securerandom'

class PatronController < ApplicationController
  layout 'layouts/patron'

  before_filter :assign_uuid

  def assign_uuid
    if !session[:patron_id]
      @patron = Patron.create!
      session[:patron_id] = @patron.id
    else
      @patron = Patron.find(session[:patron_id])
    end
  end

end