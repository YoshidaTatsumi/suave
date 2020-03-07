class ChatsController < ApplicationController
	def index
		@rooms = Room.where.not(name: nil)
		@room = Room.new
	end

	def show
		@user = User.find(params[:id])
		rooms = current_user.user_rooms.pluck(:room_id)
		user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
		if user_room.nil?
			@room =Room.new
			@room.save
			UserRoom.create(user_id: current_user.id, room_id: @room.id)
    		UserRoom.create(user_id: @user.id, room_id: @room.id)
    	else
			@room = user_room.room
		end
		@chats = @room.chats
	end

	def create
		@room = Room.new(room_params)
		@room.user_id = current_user.id
		if params[:name].nil?
			@rooms = Room.where.not(name: nil)
			flash[:notice] = "ルーム名を入力してください"
			render 'index'
		else
			if @room.save
				flash[:notice] = "ルームを作成しました"
				redirect_to talk_room_chats_path(@room)
			else
				render 'index'
			end
		end
	end

	def update
	end

	def destroy
	end

	def talk_room
		@room = Room.find(params[:id])
		rooms = current_user.user_rooms.pluck(:room_id)
		user_room = UserRoom.find_by(user_id: current_user.id, room_id: rooms)
		if user_room.nil?
			UserRoom.create(user_id: current_user.id, room_id: @room.id)
		end
		@chats = @room.chats
	end

	private
	def room_params
		params.require(:room).permit(:name, :introduction, :user_id)
	end
end
