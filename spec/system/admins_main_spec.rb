require 'rails_helper'

	describe '管理者権限のテスト' do
		let(:admin) { create(:admin) }
		let(:user) { create(:user) }
		let(:game) { create(:game, user: user) }
		let(:room) { create(:room, user: user) }
		let(:contact) { create(:contact, user: user) }
		describe 'ログインしていない場合、' do
			context 'ゲーム関連のURLにアクセス' do

				it 'ゲーム一覧画面に遷移できない' do
					visit admins_games_path
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'ゲーム詳細画面に遷移できない' do
					visit admins_game_path(game)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'ゲーム編集画面に遷移できない' do
					visit edit_admins_game_path(game)
					expect(current_path).to eq(new_admin_session_path)
				end
			end

			context 'ログインしていない場合、ユーザー関連のURLにアクセス' do
				it 'ユーザー一覧画面に遷移できない' do
					visit admins_users_path
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'ユーザー詳細画面に遷移できない' do
					visit admins_user_path(user)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'ユーザー編集画面に遷移できない' do
					visit edit_admins_user_path(user)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'フォロー一覧画面に遷移できない' do
					visit follow_admins_user_path(user)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'フォロワー一覧画面に遷移できない' do
					visit follower_admins_user_path(user)
					expect(current_path).to eq(new_admin_session_path)
				end
			end

			context 'ログインしていない場合、検索関連のURLにアクセス' do
				it '検索一覧画面に遷移できない' do
					visit ('/admins/search?utf8=✓&search=&category=user&commit=検索')
					expect(current_path).to eq(new_admin_session_path)
				end
			end

			context 'ログインしていない場合、' do
				it 'トップ画面に遷移できない' do
					visit (admins_top_path)
					expect(current_path).to eq(new_admin_session_path)
				end
			end

			context 'ログインしていない場合、お問い合わせ関連のURLにアクセス' do
				it 'お問い合わせ一覧画面に遷移できない' do
					visit (admins_contacts_path)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'お問い合わせ詳細画面に遷移できない' do
					visit (admins_contact_path(contact))
					expect(current_path).to eq(new_admin_session_path)
				end
			end

			context 'ログインしていない場合、チャット関連のURLにアクセス' do
				it 'トークルーム一覧画面に遷移できない' do
					visit (admins_chats_path)
					expect(current_path).to eq(new_admin_session_path)
				end

				it 'トークルーム詳細画面に遷移できない' do
					visit (talk_room_admins_chats_path(room))
					expect(current_path).to eq(new_admin_session_path)
				end
			end
		end
	end

