class HomesController < ApplicationController
  def top
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
