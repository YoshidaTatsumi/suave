class Room < ApplicationRecord
	has_many :user_rooms
	has_many :chats
	belongs_to :user, optional: true

	validates :name, presence: true, on: :talk_room
end
