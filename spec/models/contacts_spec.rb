
require 'rails_helper'

RSpec.describe Contact, type: :model do

	describe 'バリデーションのテスト' do
		before do
			@contact = build(:contact)
		end
		it '値が全て適切' do
			expect(@contact.valid?).to eq(true)
		end
		context 'titleカラム' do
			it 'titleが空欄でない' do
				@contact.title = ''
				expect(@contact.valid?).to eq(false)
			end
		end
		context 'contentカラム' do
			it 'contentが空でない' do
				@contact.content = ""
				expect(@contact.valid?).to eq(false)
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
	end

end