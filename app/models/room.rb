class Room < ApplicationRecord
	has_many :user_rooms, dependent: :destroy
	has_many :chats, dependent: :destroy
	belongs_to :user, optional: true

	validates :name, presence: true, on: :talk_room
end
