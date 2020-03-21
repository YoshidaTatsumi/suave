class CommentsController < ApplicationController
	def create
		@game = Game.find(params[:game_id])
		@comment = current_user.comments.new(comment_params)
		@comment.game_id = @game.id
		if @comment.save
			@game.difficulty = @game.difficulty_avg
			@game.rating = @game.rating_avg
			@game.save
			@comment.game.create_notification_comment!(current_user, @comment.id)
		else
			render 'games/show'
		end
	end

	def destroy
		@comment = Comment.find(params[:game_id])
		@game = Game.find(@comment.game.id)
		if current_user.id != @comment.user_id
			redirect_to request.referer
		else
			@comment.destroy
			@game.difficulty = @game.difficulty_avg
			@game.rating = @game.rating_avg
			@game.save
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:user_id, :game_id, :comment, :difficulty, :rating)
	end
end
