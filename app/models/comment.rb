class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :game

	has_many :notifications, dependent: :destroy

	validates :comment, presence: true
end
