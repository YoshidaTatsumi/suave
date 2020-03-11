class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :game

	has_many :notifications, dependent: :destroy

	validates :comment, presence: true
	validates :difficulty, numericality: {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :allow_nil => true}
	validates :rating, numericality: {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 10, :allow_nil => true}


end
