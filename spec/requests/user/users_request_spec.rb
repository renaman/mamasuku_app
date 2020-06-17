require 'rails_helper'

RSpec.describe "User::Users", type: :request do
	describe 'ユーザー認証のテスト' do
		describe 'ユーザー新規登録' do
			before do
				visit new_user_registrarion_path
			end
			context '新規登録画面に遷移' do
				it '新規登録に成功する' do
					fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
					fill_in 'user[email]', with: Faker::Internet.email
					fill_in 'user[password]', with: 'password'
					fill_in 'user[password_confirmation', with: 'password'
					fill_in 'user[postal_code]', with: 'postal_code'
					fill_in 'user[prefecture_code]', with: 'prefecture_code'
					fill_in 'user[city]', with: 'city'
					fill_in 'user[street]', with: 'street'
					click_button 'Sign Up'

					expect(page).to have_content 'successfully'
				end
				it '新規投稿に失敗する' do
					fill_in 'user[name]', with: ''
					fill_in 'user[email]', with: ''
					fill_in 'user[password]', with: ''
					fill_in 'user[password_confirmation', with: ''
					fill_in 'user[postal_code]', with: ''
					fill_in 'user[prefecture_code]', with: ''
					fill_in 'user[city]', with: ''
					fill_in 'user[street]', with: ''
					click_button 'Sign Up'

					expect(page).to have_content 'error'
				end
			end
		end
		describe 'ユーザログイン' do
			let(:user) { create(:user) }
			before do
				visit new_user_session_path
			end
			context 'ログイン画面に遷移' do
				let(:test_user) { user }
				it 'ログインに成功する' do
					fill_in 'user[name]', with: test_user.name
					fill_in 'user[password]', with: test_user.password
					click_button 'Log In'

					expect(page).have_content 'successfully'
				end

				it 'ログインに失敗する' do
					fill_in 'user[name]', with: ''
					fill_in 'user[passeord]', with: ''
					click_button 'Log In'

					expect(current_path).to eq(new_user_session_path)
				end
			end
		end
	end
	describe 'ユーザのテスト' do
		let(:user) { create(:user) }
		let!(:test_user2) { create(:user)}
		let!(:daiary) { create(:diary, user: user) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
		end
		describe 'サイドバーのテスト' do
			context '表示の確認' do
				it 'User Infoと表示される' do
					expect(page).to have_content('User Info')
				end
				it '画像が表示される' do
					expect(page).to have_css('img.profile_image')
				end
				it '名前が表示される' do
					expect(page).to have_css(user.name)
				end
				it '自己紹介が表示される' do
					expect(page).to have_content(user.introduction)
				end
				it '年齢が表示される' do
					expect(page).to have_content(user.age)
				end
				it '編集リンクが表示される' do
					visit user_path(user)
					expect(page).to have_link '', href: edit_users_user_path
				end
			end
		end

		describe '編集のテスト' do
			context '自分の編集画面へ遷移' do
				it '遷移できる' do
					visit_edit_user_path(user)
					expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
				end
			end
			context '他人の編集画面への遷移' do
				it '遷移できない' do
					visit edit_user_path(test_user2)
					expect(current_path).to eq('/users/' + user.id.to_s)
				end
			end
			context '表示の確認' do
				before do
					visit edit_user_path(user)
				end
				it 'User Infoと表示される' do
					expect(page).to have_content('User Info')
				end
				it '名前編集に自分の名前が表示される' do
					expect(page).to have_field 'user[name]', with: user.name
				end
				it '画像編集フォームが表示される' do
					expect(page).to have_field 'user[profile_image]'
				end
				it '自分の年齢が表示される' do
					expect(page).to have_field 'user[age]', with: user.age
				end
				it '自己紹介編集フォームに自分の自己紹介が表示される' do
					expect(page).to have_field 'user[introduction]', with: user.introduction
				end
				it '編集に成功する' do
					click_button 'Update User'
					expect(page).to have_content 'successfully'
					expext(current_path).to eq('users/' + user.id.to_s)
				end
				it '編集に失敗する' do
					fill_in 'user[name]', with: ''
					click_button 'Update User'
					expect(page).to have_content 'error'
					expect(current_path).to eq('users' + user.id.to_s + '/edit')
				end
			end
		end
		describe '詳細のテスト' do
			before do
				visit user_path(user)
			end
			context '表示の確認' do
				it 'User Indexと表示される' do
					expect(page).to have_content('User Index')
				end
				it '投稿一覧のTitleのリンク先が正しい' do
					expect(page).to have_link diary.title, href: diary_path(diary)
				end 
			end
		end
	end
end
