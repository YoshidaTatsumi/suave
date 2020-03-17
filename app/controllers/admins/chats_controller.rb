class Admins::ChatsController < ApplicationController
	def index
		@rooms = Room.where.not(name: nil)
	end

	def update
		@room = Room.find(params[:id])
		if @room.update(room_params)
			flash[:notice] = "編集が完了しました"
			redirect_to talk_room_admins_chats_path(@room)
		else
			flash[:danger] = "ルーム名を入力してください"
			redirect_to talk_room_admins_chats_path(@room)
		end
	end

	def destroy
		room = Room.find(params[:id])
		room.destroy
		flash[:notice] = "ルームを削除しました"
		redirect_to admins_chats_path
	end

	def talk_room
		@room = Room.find(params[:id])
	end

	private
	def room_params
		params.require(:room).permit(:name, :introduction)
	end
end
