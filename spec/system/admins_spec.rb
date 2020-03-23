require 'rails_helper'


RSpec.describe Admin, type: :system do


	describe '管理者認証のテスト' do

		describe '管理者ログイン' do
			let(:admin) { create(:admin) }
			before do
				visit new_admin_session_path
			end
			context 'ログイン画面に遷移' do

				it 'ログインに成功' do
		        fill_in 'admin[email]', with: admin.email
		        fill_in 'admin[password]', with: admin.password
		        click_button 'ログイン'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(admins_top_path)
				end

				it 'ログインに失敗' do
		        fill_in 'admin[email]', with: ''
		        fill_in 'admin[password]', with: ''
		        click_button 'ログイン'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(new_admin_session_path)
				end
			end
		end
	end
end