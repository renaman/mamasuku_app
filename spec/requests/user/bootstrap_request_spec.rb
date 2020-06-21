require 'rails_helper'

describe 'bootstrapのテスト' do
	let(:user) { create(:user) }
	let!(:diary) { create(:diary, user: user) }
	describe 'グリッドシステムのテスト' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
			visit diaries_path
		end
		context 'ユーザー関連画面' do
			it 'ユーザ一覧画面' do
				visit user_path(user)
				expect(page).to have_selector('.container .row .col-md-4')
				expect(page).to have_selector('.container .row .col-md-8')
			end
		end
		context '投稿関連画面' do
			it '一覧画面' do
				visit diaries_path
				expect(page).to have_selector('.container .row .col-md-4')
				expect(page).to have_selector('.container .row .col-md-8')
			end
		end
	end
end