class GamesController < ApplicationController
	def index
		games = Game.all
		@index_games = Game.order("RANDOM()").limit(10)
		@desc_games = games.order(created_at: :desc).page(params[:new_game]).per(10)
		@favorite_games = games.where.not(rating: nil).order(rating: :desc).page(params[:favorite_game]).per(10)
		@difficult_games = games.where.not(difficulty: nil).order(difficulty: :desc).page(params[:difficult_game]).per(10)
		@easy_games = games.where.not(difficulty: nil).order(difficulty: :asc).page(params[:easy_game]).per(10)

		respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def new
		@game = Game.new
		@game.screenshots.build
	end

	def show
		@game = Game.find(params[:id])
		@comment = Comment.new
	end

	def edit
		@game = Game.find(params[:id])
		if @game.user.id != current_user.id
			redirect_to games_path
		end
	end

	def create
		@game = Game.new(game_params)
		@game.user_id = current_user.id
		if @game.save
			flash[:notice] = "アップロードが完了しました"
			redirect_to game_path(@game)
		else
			render 'new'
		end
	end

	def update
		@game = Game.find(params[:id])
		if @game.update(game_params)
			flash[:notice] = "変更を保存しました"
			redirect_to game_path(@game)
		else
			render 'edit'
		end
	end

	def destroy
		game = Game.find(params[:id])
		game.destroy
		flash[:notice] = "ゲームを削除しました"
		redirect_to root_path
	end

	def more_game
		if params[:place] == "user"
			@games = Game.where(user_id: params[:id_user]).page(params[:page]).per(9)
			@user = User.find(params[:id_user])
		end
	end

	private
	def game_params
		params.require(:game).permit(:title, :introduction, :url, :tag_list, screenshots_attributes: [:id, :game_id, :image, :_destroy])
	end

end
