
require 'rails_helper'

RSpec.describe Screenshot, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@screenshot = build(:screenshot)
		end
		it '値が全て適切' do
			expect(@screenshot.valid?).to eq(true)
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Gameとの関係' do
			it '1:Nとなっている' do
				expect(Screenshot.reflect_on_association(:game).macro).to eq :belongs_to
			end
		end
	end

end