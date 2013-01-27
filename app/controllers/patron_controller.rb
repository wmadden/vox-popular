require 'securerandom'

class PatronController < ApplicationController
  layout 'layouts/patron'

  before_filter :assign_uuid

  def assign_uuid
    puts "session = #{session.to_hash}"
    if !session[:patron_id]
      puts "creating patron"
      @patron = Patron.create!
      session[:patron_id] = @patron.id
    else
      puts "patron exists"
      @patron = Patron.find(session[:patron_id])
    end
  end

end