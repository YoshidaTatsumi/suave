class Game < ApplicationRecord
	has_many :notifications, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :screenshots, dependent: :destroy

	belongs_to :user

	#fields_forに必要な記述
	accepts_nested_attributes_for :screenshots
	#refileで複数枚画像保存する場合の記述
	accepts_attachments_for :screenshots, attachment: :image, append: true

	validates :title, presence: true, length: {maximum: 199}
	validates :introduction, presence: true

	#acts-as-taggable-onを使用できるように記述
	acts_as_taggable

	def rating_avg
		comments.where.not(rating: nil).average(:rating)
	end

	def difficulty_avg
		comments.where.not(difficulty: nil).average(:difficulty)
	end
end
