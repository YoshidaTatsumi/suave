class Admins::UsersController < ApplicationController
	def index
		@users = User.all.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user =User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "ユーザーを編集しました"
			redirect_to admins_user_path(@user)
		else
			render "edit"
		end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		redirect_to admins_users_path
	end

	def status_change
		user = User.find(params[:id])
		user.update(change_params)
		redirect_to admins_user_path(user)
	end

	def follow
		@user = User.find(params[:id])
	end

	def follower
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :image)
	end

	def change_params
		params.permit(:status)
	end
end
