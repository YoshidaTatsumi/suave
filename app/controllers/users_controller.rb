class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@users = User.where(status: true).page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
		if params[:place] == "notifications"
			notification = Notification.find(params[:notification])
			notification.update_attributes(checked: true)
		end
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != @user.id
			redirect_to users_path
		end
	end

	def update
		@user =User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "編集が完了しました"
			redirect_to user_path(@user)
		else
			flash[:danger] = "入力ミスがあります"
			render "edit"
		end
	end

	def status_change
		user = User.find(params[:id])
		sign_out(User)
		user.update(change_params)
		flash[:notice] = "退会処理が完了しました"
		redirect_to root_path
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		flash[:notice] = "退会処理が完了しました"
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
