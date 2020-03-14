class Admins::CommentsController < ApplicationController
	def destroy
		@comment = Comment.find(params[:game_id])
		@game = Game.find(@comment.game_id)
		@comment.destroy
		@game.difficulty = @game.difficulty_avg
		@game.rating = @game.rating_avg
		@game.save
	end
end
