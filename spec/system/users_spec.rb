require 'rails_helper'


RSpec.describe User, type: :system do


	describe 'ユーザー認証のテスト' do
		describe 'ユーザーの新規登録' do

			before do
				visit new_user_registration_path
			end

			context '新規登録画面に遷移' do
				it '新規登録に成功' do
			        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
			        fill_in 'user[email]', with: Faker::Internet.email
			        fill_in 'user[password]', with: 'test01'
			        fill_in 'user[password_confirmation]', with: 'test01'
			        click_button '登録する'
			        expect(current_path).to eq(root_path)
				end

				it '新規登録に失敗' do
			        fill_in 'user[name]', with: ''
			        fill_in 'user[email]', with: ''
			        fill_in 'user[password]', with: ''
			        fill_in 'user[password_confirmation]', with: ''
			        click_button '登録する'
			        expect(page).to have_content 'error'
				end
			end
		end

		describe 'ユーザーログイン' do
			let(:user) { create(:user) }
			before do
				visit new_user_session_path
			end
			context 'ログイン画面に遷移' do

				it 'ログインに成功' do
		        fill_in 'user[email]', with: user.email
		        fill_in 'user[password]', with: user.password
		        click_button 'ログイン'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(root_path)
				end

				it 'ログインに失敗' do
		        fill_in 'user[email]', with: ''
		        fill_in 'user[password]', with: ''
		        click_button 'ログイン'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(new_user_session_path)
				end
			end
		end
	end

	describe 'ユーザーのテスト' do
		let(:user) { create(:user) }
		let!(:user2) { create(:user) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'ログイン'
		end

		describe '編集のテスト' do
			context '自分の編集画面への遷移' do
				it '遷移できる' do
					visit edit_user_path(user)
					expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
				end
			end
			context '他人の編集画面への遷移' do
				it '遷移できない' do
					visit edit_user_path(user2)
					expect(current_path).to eq(users_path)
				end
			end

		    context '編集の確認' do
				before do
					visit edit_user_path(user)
				end
				it '編集に成功する' do
					click_button '変更を保存'
					expect(current_path).to eq('/users/' + user.id.to_s)
				end
				it '編集に失敗する' do
					fill_in 'user[name]', with: ''
					click_button '変更を保存'
					expect(current_path).to eq('/users/' + user.id.to_s)
				end
			end
		end
	end
end