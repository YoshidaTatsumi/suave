class ScreenshotsController < ApplicationController

	def edit
		@game = Game.find(params[:game_id])
		@screenshot = Screenshot.new
		if @game.user_id != current_user.id
			redirect_to games_path
		end
	end

	def create
		@screenshot = Screenshot.new(screenshot_params)
		if @screenshot.image.present?
			@screenshot.game_id = params[:game_id]
			@screenshot.save
			flash[:notice] = "画像を保存しました"
			redirect_to request.referer
		else
			@game = Game.find(params[:game_id])
			flash[:notice] = "画像を選択してください"
			redirect_to edit_game_screenshots_path(@game)
		end
	end

	def update
		screenshot = Screenshot.find(params[:game_id])
		screenshot.update(screenshot_params)
		flash[:notice] = "画像を保存しました"
		redirect_to request.referer
	end

	def destroy
		screenshot = Screenshot.find(params[:game_id])
		screenshot.destroy
		flash[:notice] = "画像を削除しました"
		redirect_to request.referer
	end

	private
	def screenshot_params
		params.require(:screenshot).permit(:image)
	end
end
