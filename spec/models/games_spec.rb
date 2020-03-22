
require 'rails_helper'

RSpec.describe Game, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@game = build(:game)
		end
		it '値が全て適切' do
			expect(@game.valid?).to eq(true)
		end
		context 'titleカラム' do
			it 'titleが空欄でない' do
				@game.title = ''
				expect(@game.valid?).to eq(false)
			end
		    it '30文字以下であること' do
		    	@game.title = Faker::Lorem.characters(number:31)
		    	expect(@game.valid?).to eq(false)
		    end
		end
		context 'introductionカラム' do
			it 'introductionが空でない' do
				@game.introduction = ""
				expect(@game.valid?).to eq(false)
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Game.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Notificationとの関係' do
			it '1:Nとなっている' do
				expect(Game.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
		context 'Commentとの関係' do
			it '1:Nとなっている' do
				expect(Game.reflect_on_association(:comments).macro).to eq :has_many
			end
		end
		context 'Screenshotsとの関係' do
			it '1:Nとなっている' do
				expect(Game.reflect_on_association(:screenshots).macro).to eq :has_many
			end
		end
	end

end