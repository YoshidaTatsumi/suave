class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	chat = Chat.create(user_id: data['current_user_id'], room_id: params['room_id'], message: data['data'])
    template = ApplicationController.render_with_signed_in_user(chat.user, partial: 'chats/message', locals: { chat: chat })
    room = Room.find(params['room_id'])
    unless room.name.present?
      room.user_rooms.each do |user_room|
        notification = chat.user.active_notifications.new(
          visited_id: user_room.user.id,
          action: 'chat'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    ActionCable.server.broadcast "chat_channel_#{params['room_id']}", data: template
  end
end
