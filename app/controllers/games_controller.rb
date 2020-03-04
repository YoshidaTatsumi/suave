class GamesController < ApplicationController
	def index
		@games = Game.all
	end

	def new
		@game = Game.new
		@game.screenshots.build  # fields_forのために親子モデルを関連付け
	end

	def show
		@game = Game.find(params[:id])
	end

	def edit
		@game = Game.find(params[:id])
	end

	def create
		@game = Game.new(game_params)
		params[:images_attributes][:"0"][:image].each do |image|
			@game.screenshots.build(image)
		end
		if @game.save
			redirect_to game_path(@game)
		else
			render 'new'
		end
	end

	def update
	end

	def destroy
	end

	private
	def game_params
		params.require(:game).permit(:title, :introduction, :url, screenshots_images: [])
	end

end
