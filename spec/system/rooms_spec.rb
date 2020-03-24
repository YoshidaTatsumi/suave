require 'rails_helper'


RSpec.describe Room, type: :system do

	describe 'チャットルームテスト' do
		let(:user) { create(:user) }
		let!(:room) { create(:room, user: user) }

		before do
			visit new_user_session_path
		  	fill_in 'user[email]', with: user.email
		  	fill_in 'user[password]', with: user.password
		  	click_button 'ログイン'
		end

		describe 'チャットルーム一覧画面' do
			before do
				visit chats_path
			end
			context 'ルーム作成テスト' do

				it '作成に成功する' do
					click_button 'ルーム作成'
					fill_in 'room[name]', with: room.name
					fill_in 'room[introduction]', with: Faker::Lorem.characters(number:10)
					click_button '作成'
					expect(page).to have_content room.name
				end

				it '作成に失敗する' do
					click_button 'ルーム作成'
					fill_in 'room[name]', with: ''
					click_button '作成'
					expect(current_path).to eq(chats_path)
				end
			end
		end
	end

end