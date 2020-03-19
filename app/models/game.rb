class Game < ApplicationRecord
	has_many :notifications, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :screenshots, dependent: :destroy

	belongs_to :user

	#nested_form_fieldsに必要な記述
	accepts_nested_attributes_for :screenshots, allow_destroy: true

	validates :title, presence: true, length: {maximum: 30}
	validates :introduction, presence: true

	#acts-as-taggable-onを使用できるように記述
	acts_as_taggable

	#ファイルを受け取る為定義
	attr_accessor :file

	def rating_avg
		comments.where.not(rating: nil).average(:rating)
	end

	def difficulty_avg
		comments.where.not(difficulty: nil).average(:difficulty)
	end
end
