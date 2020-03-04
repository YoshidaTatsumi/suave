class GamesController < ApplicationController
	def index
		@games = Game.all
	end

	def new
		@game = Game.new
		@game.screenshots.build
	end

	def show
		@game = Game.find(params[:id])
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
			if params[:screenshots_attributes].present?
				params[:screenshots_attributes][:"0"][:image].each do |image|
					screenshot = Screenshot.new(game_id: @game.id, image: image)
					screenshot.save
				end
			end
			redirect_to game_path(@game)
		else
			render 'new'
		end
	end

	def update
		@game = Game.find(params[:id])
		if @game.update(game_params)
			if params[:screenshots_attributes].present?
				@game.screenshots.destroy_all
				params[:screenshots_attributes][:"0"][:image].each do |image|
					screenshot = Screenshot.new(game_id: @game.id, image: image)
					screenshot.save
				end
			end
			redirect_to game_path(@game)
		else
			render 'edit'
		end
	end

	def destroy
	end

	private
	def game_params
		params.require(:game).permit(:title, :introduction, :url, :tag_list)
	end

end
