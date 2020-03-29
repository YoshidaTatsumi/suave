class SearchController < ApplicationController
	def search
		if params[:category] == "user"
			@searches = User.where("name LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
		elsif params[:category] == "game"
			@searches = Game.where("title LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
		elsif params[:category] == "tag"
			@searches = Game.tagged_with("#{params[:search]}").page(params[:page]).per(10)
		elsif params[:tag].present?
			@searches = Game.tagged_with("#{params[:tag]}").page(params[:page]).per(10)
		else
			redirect_to root_path
		end
	end
end
