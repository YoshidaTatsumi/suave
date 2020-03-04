class Game < ApplicationRecord
	has_many :notifications, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :screenshots, dependent: :destroy
	#fields_forに必要な記述
	accepts_nested_attributes_for :screenshots
	#refileで複数枚画像保存する場合の記述
	accepts_attachments_for :screenshots, attachment: :images

	validates :title, presence: true, length: {maximum: 199}
	validates :introduction, presence: true

end
