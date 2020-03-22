
require 'rails_helper'

RSpec.describe Notification, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@notification = build(:notification)
		end
		it '値が全て適切' do
			expect(@notification.valid?).to eq(true)
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
				expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
			end
		end
		context 'Gameとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:game).macro).to eq :belongs_to
			end
		end
		context 'Commentとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
			end
		end
	end

end