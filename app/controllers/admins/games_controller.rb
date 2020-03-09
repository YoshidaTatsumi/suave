class Admins::GamesController < ApplicationController
	def index
		if params[:place] == "user"
			@games = Game.where(user_id: params[:user_id])
		elsif params[:place] == "top"
			@games = Game.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
		else
			@games = Game.all
		end
	end

	def show
		@game = Game.find(params[:id])
	end

	def edit
		@game = Game.find(params[:id])
	end

	def update
		@game = Game.find(params[:id])
		if @game.update(game_params)
			flash[:notice] = "変更を保存しました"
			redirect_to admins_game_path(@game)
		else
			render 'edit'
		end
	end

	def destroy
		game = Game.find(params[:id])
		game.destroy
		flash[:notice] = "ゲームを削除しました"
		redirect_to admins_games_path
	end

	private
	def game_params
		params.require(:game).permit(:title, :introduction, :url, :tag_list)
	end
end
