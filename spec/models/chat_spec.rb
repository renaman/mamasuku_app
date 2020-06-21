require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it '1:Nとなっている' do
				expect(Chat.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Roomモデルとの関係' do
			it '1:Nとなっている' do
				expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
			end
		end
		context 'Notificationモデルとの関係' do
			it '1:Nとなっている' do
				expect(Chat.reflect_on_association(:notification).macro).to eq :has_one
			end
		end
	end
end
