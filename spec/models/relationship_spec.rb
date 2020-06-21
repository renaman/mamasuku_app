require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'アソシエーションのテスト' do
		context 'User(followed)モデルとの関係' do
			it '1:Nとなっている' do
				expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
			end
		end
		context 'User(follower)モデルとの関係' do
			it '1:Nとなっている' do
				expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
			end
		end
	end
end
