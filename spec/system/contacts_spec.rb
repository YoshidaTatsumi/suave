require 'rails_helper'


RSpec.describe Contact, type: :system do

	describe 'お問い合わせテスト' do
		let(:user) { create(:user) }
		let!(:contact) { create(:contact, user: user) }

		before do
			visit new_user_session_path
		  	fill_in 'user[email]', with: user.email
		  	fill_in 'user[password]', with: user.password
		  	click_button 'ログイン'
		end

		describe 'お問い合わせフォーム画面' do
			before do
				visit new_contact_path
			end
			context '投稿テスト' do

				it '作成に失敗する' do
					fill_in 'contact[title]', with: ''
					click_button '送信'
					expect(current_path).to eq("/contacts")
				end
			end
		end
	end

end