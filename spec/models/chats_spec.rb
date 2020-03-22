
require 'rails_helper'

RSpec.describe Chat, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@chat = build(:chat)
		end
		it '値が全て適切' do
			expect(@chat.valid?).to eq(true)
		end
		context 'messageカラム' do
			it 'messageが空欄でない' do
				@chat.message = ''
				expect(@chat.valid?).to eq(false)
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Chat.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Roomとの関係' do
			it '1:Nとなっている' do
				expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
			end
		end
	end

end