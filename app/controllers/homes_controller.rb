class HomesController < ApplicationController
  def top
    @favorite_games = Game.where.not(rating: nil).order(rating: :desc).first(3)
    @new_games = Game.order(created_at: :desc).first(3)
    @rooms = Room.where.not(name: nil).order(created_at: :desc).first(5)
  end

  def about
  end

  def check
  	notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
  	notifications_not = notifications.where(checked: false)

  	notifications_not.each do |notification_not|
  		notification_not.update_attributes(checked: true)
  	end
  	redirect_to request.referer

  end
end
