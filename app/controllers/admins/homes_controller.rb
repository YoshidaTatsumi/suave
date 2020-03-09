class Admins::HomesController < ApplicationController
	def top
		@games = Game.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
	end
end
