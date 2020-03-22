
require 'rails_helper'

RSpec.describe UserRoom, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@user_room = build(:user_room)
		end
		it '値が全て適切' do
			expect(@user_room.valid?).to eq(true)
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(UserRoom.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Chatとの関係' do
			it '1:Nとなっている' do
				expect(UserRoom.reflect_on_association(:room).macro).to eq :belongs_to
			end
		end
	end

end