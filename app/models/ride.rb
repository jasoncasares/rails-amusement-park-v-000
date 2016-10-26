class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if (user.height < attraction.min_height) && (user.tickets < attraction.tickets)
      @alert = "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif user.height < attraction.min_height
      @alert = "Sorry. You are not tall enough to ride the #{attraction.name}."
    elsif user.tickets < attraction.tickets
      @alert = "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    else
      new_ticket_total = (user.tickets -= attraction.tickets)
      new_nausea_rating = (user.nausea += attraction.nausea_rating)
      new_happiness_rating = (user.happiness += attraction.happiness_rating)
      user.update(tickets: new_ticket_total, nausea: new_nausea_rating, happiness: new_happiness_rating)
    end
  end
end
