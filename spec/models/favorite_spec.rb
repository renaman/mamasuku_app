require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'アソシエーションのテスト' do
		context 'Diaryモデルとの関係' do
			it '1:Nとなっている' do
				expect(Favorite.reflect_on_association(:diary).macro).to eq :belongs_to
			end
		end
		context 'Userモデルとの関係' do
			it '1:Nとなっている' do
				expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
	end
end
