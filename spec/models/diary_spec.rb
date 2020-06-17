require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:diary) { build(:diary, user_id: user.id) }

    context 'titleカラム' do
    	it '空白でないこと' do
    		diary.title = ''
    		expect(diary.valid?).to eq false;
    	end
    end
    context 'bodyカラム' do
    	it '空欄でないこと' do
    		diary.body = ''
    		expect(diary.valid?).to eq false;
    	end
    end
  end
  describe 'アソシエーションのテスト' do
  	context 'Userモデルとの関係' do
  		it 'N:1となっている' do
  			expect(Diary.reflect_on_association(:user).macro).to eq :belongs_to
  		end
  	end
  end
end
