require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'アソシエーションのテスト' do
		context 'Diaryモデルとの関係' do
			it '1:Nとなっている' do
				expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
	end
end
