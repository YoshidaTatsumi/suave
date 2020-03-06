class Admins::CommentsController < ApplicationController
	def destroy
		@comment = Comment.find(params[:game_id])
		@comment.destroy
	end
end
