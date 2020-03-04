class Screenshot < ApplicationRecord
	belongs_to :game

	attachment :image
end
