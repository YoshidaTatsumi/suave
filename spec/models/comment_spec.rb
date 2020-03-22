
require 'rails_helper'

RSpec.describe Comment, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@comment = build(:comment)
		end
		it '値が全て適切' do
			expect(@comment.valid?).to eq(true)
		end
		context 'commentカラム' do
			it 'commentが空欄でない' do
				@comment.comment = ''
				expect(@comment.valid?).to eq(false)
			end
		end
		context 'difficultyカラム' do
			it 'difficultyが空でも良い' do
				@comment.difficulty = ""
				expect(@comment.valid?).to eq(true)
			end
			it '0以上の値である' do
				@comment.difficulty = -1
				expect(@comment.valid?).to eq(false)
			end
			it '100以下の値である' do
				@comment.difficulty = 101
				expect(@comment.valid?).to eq(false)
			end
		end
		context 'ratingカラム' do
			it 'ratingが空でも良い' do
				@comment.rating = ""
				expect(@comment.valid?).to eq(true)
			end
			it '0以上の値である' do
				@comment.rating = -1
				expect(@comment.valid?).to eq(false)
			end
			it '10以下の値である' do
				@comment.rating = 11
				expect(@comment.valid?).to eq(false)
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Gameとの関係' do
			it '1:Nとなっている' do
				expect(Comment.reflect_on_association(:game).macro).to eq :belongs_to
			end
		end
		context 'Notificationとの関係' do
			it '1:Nとなっている' do
				expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end
	end

end