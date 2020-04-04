class Admins::SearchController < ApplicationController
	before_action :authenticate_admin!

	def search
		if params[:category] == "user"
			@searches = User.where("name LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
		elsif params[:category] == "game"
			@searches = Game.where("title LIKE?","%#{params[:search]}%").page(params[:page]).per(10)
		elsif params[:category] == "tag"
			# 部分一致でタグを検索
			@searches = ActsAsTaggableOn::Tag.named_like("#{params[:search]}")
		elsif params[:tag].present?
			@searches = Game.tagged_with("#{params[:tag]}").page(params[:page]).per(10)
		else
			redirect_to admins_top_path
		end
	end
end
