class CommentsController < ApplicationController
	def create
		@game = Game.find(params[:game_id])
		@comment = current_user.comments.new(comment_params)
		@comment.game_id = @game.id
		if @comment.save
			# redirect_to request.referer
		else
			render 'games/show'
		end
	end

	def destroy
		@comment = Comment.find(params[:game_id])
		if current_user.id != @comment.user_id
			redirect_to request.referer
		end
		@comment.destroy
		flash[:notice] = "コメントを削除しました"
	end

	private
	def comment_params
		params.require(:comment).permit(:user_id, :game_id, :comment, :difficulty, :rating)
	end
end
