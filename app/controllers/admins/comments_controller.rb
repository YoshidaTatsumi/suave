class Admins::CommentsController < ApplicationController
	def destroy
		@comment = Comment.find(params[:game_id])
		@game = Game.find(@comment.game_id)
		@comment.destroy
	end
end
