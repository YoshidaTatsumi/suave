class Room < ApplicationRecord
	has_many :user_rooms
	has_many :chats
	belongs_to :user

	validates :name, presence: true, on: :create
	validates :name, presence: true, on: :update
end
