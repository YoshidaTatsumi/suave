require 'rails_helper'


RSpec.describe Game, type: :system do

	describe 'ゲームテスト' do
		let(:user) { create(:user) }
		let!(:game) { create(:game, user: user) }
		let!(:user2) { create(:user) }
		let!(:game2) { create(:game, user: user2)}
		before do
			visit new_user_session_path
		  	fill_in 'user[email]', with: user.email
		  	fill_in 'user[password]', with: user.password
		  	click_button 'ログイン'
		end

		describe '投稿画面' do
			before do
				visit new_game_path
			end
			context '投稿テスト' do

				it '作成に成功する' do
					fill_in 'game[title]', with: Faker::Lorem.characters(number:10)
					fill_in 'game[introduction]', with: Faker::Lorem.characters(number:20)
					fill_in 'game[file]', with: game.file
					click_button 'アップロード'
					expect(current_path).to eq(game_path(game))
				end

				it '作成に失敗する' do
					fill_in 'game[title]', with: ''
					click_button 'アップロード'
					expect(current_path).to eq(games_path)
				end
			end
		end

		describe '編集のテスト' do
			context '編集画面へ遷移' do
				it '遷移できる' do
					visit edit_game_path(game)
					expect(current_path).to eq('/games/' + game.id.to_s + '/edit')
				end
			end

			context '他人の編集画面へ遷移できない' do
				it '遷移できない' do
					visit edit_game_path(game2)
					expect(current_path).to eq(games_path)
				end
			end

			context '更新のテスト' do
				it '編集に成功する' do
					visit edit_game_path(game)
					click_button '変更を保存'
					expect(current_path).to eq(game_path(game))
				end
				it '編集に失敗する' do
					visit edit_game_path(game)
					fill_in 'game[title]', with: ''
					click_button '変更を保存'
					expect(current_path).to eq('/games/' + game.id.to_s)
				end
			end


		end




	end

end