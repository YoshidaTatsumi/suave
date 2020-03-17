class UsersController < ApplicationController
	def index
		@users = User.where(status: true).page(params[:page]).per(10)
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
			redirect_to user_path(@user)
		else
			render "edit"
		end
	end

	def status_change
		user = User.find(params[:id])
		sign_out(User)
		user.update(change_params)
		redirect_to root_path
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		redirect_to root_path
	end

	def follow
		user = User.find(params[:id])
		@users = user.following_user.page(params[:page]).per(10)
	end

	def follower
		user = User.find(params[:id])
		@users = user.follower_user.page(params[:page]).per(10)
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :image)
	end

	def change_params
		params.permit(:status)
	end
end
