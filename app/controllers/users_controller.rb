class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]

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

	def chenge_password
		@user = User.find(params[:id])
		redirect_to root_path if @user.id != current_user.id
	end

	def update_password
		@user = User.find(params[:id])
		if @user.id == current_user.id
			if @user.valid_password?(password_params[:old_password])	#入力された現在のパスワードが正しいか
				if password_params[:new_password].length >= 6
					if password_params[:new_password] == password_params[:new_password_confirm]
						@user.reset_password(password_params[:new_password], password_params[:new_password_confirm])
						# reset_passwordすると自動雨滴にログアウトする。ログアウトさせたくない場合はここで再ログインさせる必要あり。
						flash[:success] = 'パスワードを変更しました。変更に伴いログアウトしました。'
						redirect_to root_path
					else
						flash[:danger] = "新しいパスワードの再入力が間違ってます"
						render 'chenge_password'
					end
				else
					flash[:danger] = "パスワードは6文字以上で登録してください"
					render 'chenge_password'
				end
			else
				flash[:danger] = "パスワードが間違ってます"
				render 'chenge_password'
			end
		else
			redirect_to root_path
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :image)
	end

	def change_params
		params.permit(:status)
	end

	def password_params
		params.require(:user).permit(:new_password, :new_password_confirm, :old_password)
	end
end
