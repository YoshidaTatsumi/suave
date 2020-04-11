class Admins::ChatsController < ApplicationController
	before_action :authenticate_admin!

	def index
		# チャットを投稿するとroomのupdated_atが更新されるようにしている。（詳細chat_channel）
		@rooms = Room.where.not(name: nil).order(updated_at: :asc).page(params[:page]).per(8).reverse_order
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

	def chat_destroy
		chat = Chat.find(params[:chat_id])
		chat.destroy
		flash[:notice] = "１件のチャットを削除しました"
		redirect_to request.referer
	end

	def talk_room
		@room = Room.find(params[:id])
	end

	private
	def room_params
		params.require(:room).permit(:name, :introduction)
	end
end
