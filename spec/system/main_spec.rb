require 'rails_helper'

	describe 'ユーザー権限のテスト' do
		let(:user) { create(:user) }
		let(:game) { create(:game, user: user) }
		let(:room) { create(:room, user: user) }
		describe 'ログインしていない場合' do
			context 'ゲーム関連のURLにアクセス' do

				it 'ゲーム一覧画面に遷移できる' do
					visit games_path
					expect(current_path).to eq(games_path)
				end

				it 'ゲーム詳細画面に遷移できる' do
					visit game_path(game)
					expect(current_path).to eq(game_path(game))
				end

				it 'ゲーム投稿画面に遷移できない' do
					visit new_game_path
					expect(current_path).to eq(new_user_session_path)
				end

				it 'ゲーム編集画面に遷移できない' do
					visit edit_game_path(game)
					expect(current_path).to eq(new_user_session_path)
				end
			end

			context 'ログインしていない場合、ユーザー関連のURLにアクセス' do

				it 'ユーザー詳細画面に遷移できる' do
					visit user_path(user)
					expect(current_path).to eq(user_path(user))
				end

				it 'ユーザー編集画面に遷移できない' do
					visit edit_user_path(user)
					expect(current_path).to eq(new_user_session_path)
				end

				it 'フォロー一覧画面に遷移できない' do
					visit follow_user_path(user)
					expect(current_path).to eq(new_user_session_path)
				end

				it 'フォロワー一覧画面に遷移できない' do
					visit follower_user_path(user)
					expect(current_path).to eq(new_user_session_path)
				end
			end

			context 'ログインしていない場合、検索関連のURLにアクセス' do
				it '検索一覧画面に遷移できる' do
					visit ('/search?utf8=✓&search=&category=user&commit=検索')
					expect(current_path).to eq(search_path)
				end
			end

			context 'ログインしていない場合、' do
				it 'トップ画面に遷移できる' do
					visit (root_path)
					expect(current_path).to eq(root_path)
				end

				it 'Suaveとは画面に遷移できる' do
					visit (homes_about_path)
					expect(current_path).to eq(homes_about_path)
				end
			end

			context 'ログインしていない場合、お問い合わせ関連のURLにアクセス' do
				it 'お問い合わせフォーム画面に遷移できる' do
					visit (new_contact_path)
					expect(current_path).to eq(new_user_session_path)
				end
			end

			context 'ログインしていない場合、チャット関連のURLにアクセス' do
				it 'トークルーム一覧画面に遷移できる' do
					visit (chats_path)
					expect(current_path).to eq(chats_path)
				end

				it 'DM画面に遷移できない' do
					visit (chat_path(user))
					expect(current_path).to eq(new_user_session_path)
				end

				it 'トークルーム詳細画面に遷移できない' do
					visit (talk_room_chats_path(room))
					expect(current_path).to eq(new_user_session_path)
				end
			end
		end
	end

