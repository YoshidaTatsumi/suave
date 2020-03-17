class SearchController < ApplicationController
	def search
		if params[:category] == "user"
			if params[:search_method] == "perfect_match"
				@searches = User.where(name: "#{params[:search]}").page(params[:page]).per(10)
			elsif params[:search_method] == "partial_match"
				@searches = User.where("name LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
			end

		elsif params[:category] == "game"
			if params[:search_method] == "perfect_match"
				@searches = Game.where(title: "#{params[:search]}").page(params[:page]).per(10)
			elsif params[:search_method] == "partial_match"
				@searches = Game.where("title LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
			end

		elsif params[:tag].present?
			@searches = Game.tagged_with("#{params[:tag]}").page(params[:page]).per(10)

		else
			redirect_to root_path
		end
	end
end
