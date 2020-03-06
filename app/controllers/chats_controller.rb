class ChatsController < ApplicationController
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
end
