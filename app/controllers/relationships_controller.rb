class RelationshipsController < ApplicationController
	def create
		user = User.find(params[:user_id])
		if current_user.id == user.id
			redirect_to request.referer
		else
			current_user.follow(params[:user_id])
			redirect_to request.referer
		end
	end

	def destroy
		user = User.find(params[:user_id])
		if current_user.id == user.id
			redirect_to request.referer
		else
			current_user.unfollow(params[:user_id])
			redirect_to request.referer
		end
	end
end
