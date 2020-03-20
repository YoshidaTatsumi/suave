class Admins::HomesController < ApplicationController
	def top
		@contacts = Contact.where(created_at: Time.now.in_time_zone("Tokyo").beginning_of_day..Time.now.in_time_zone("Tokyo").end_of_day)
		@games = Game.where(created_at: Time.now.in_time_zone("Tokyo").beginning_of_day..Time.now.in_time_zone("Tokyo").end_of_day)
	end
end
