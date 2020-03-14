class Admins::SearchController < ApplicationController
	def search
		if params[:category] == "user"
			if params[:search_method] == "perfect_match"
				@searches = User.where(name: "#{params[:search]}")
			elsif params[:search_method] == "partial_match"
				@searches = User.where("name LIKE?","%#{params[:search]}%")
			end

		elsif params[:category] == "game"
			if params[:search_method] == "perfect_match"
				@searches = Game.where(title: "#{params[:search]}")
			elsif params[:search_method] == "partial_match"
				@searches = Game.where("title LIKE?","%#{params[:search]}%")
			end

		elsif params[:tag].present?
			@searches = Game.tagged_with("#{params[:tag]}")
		end
	end
end
