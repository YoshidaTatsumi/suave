class Chat < ApplicationRecord
	# user_id = nil = adminとする為、optional: trueにする
	belongs_to :user, optional: true
	belongs_to :room

	validates :message, presence: true
end
