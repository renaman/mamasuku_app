require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'アソシエーションのテスト' do
		context 'Chatモデルとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:chat).macro).to eq :belongs_to
			end
		end
		context 'User(visited)モデルとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
			end
		end
		context 'User(visiter)モデルとの関係' do
			it '1:Nとなっている' do
				expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
			end
		end
	end
end
