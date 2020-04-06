
require 'rails_helper'

RSpec.describe Room, type: :model do

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