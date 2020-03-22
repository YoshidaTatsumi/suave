
require 'rails_helper'

RSpec.describe Room, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@room = build(:room)
		end
		it '値が全て適切' do
			expect(@room.valid?).to eq(true)
		end
		context 'nameカラム' do
			it 'nameが空でない' do
				@room.name = ""
				expect(@room.valid?).to eq(false)
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Room.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Chatとの関係' do
			it '1:Nとなっている' do
				expect(Room.reflect_on_association(:chats).macro).to eq :has_many
			end
		end
		context 'UserRoomとの関係' do
			it '1:Nとなっている' do
				expect(Room.reflect_on_association(:user_rooms).macro).to eq :has_many
			end
		end
	end

end