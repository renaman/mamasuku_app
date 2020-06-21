require 'rails_helper'

RSpec.describe "User::Diaries", type: :request do
	describe '投稿のテスト' do
		let(:user) { create(:user) }
		let!(:user2) { create(:user) }
		let!(:diary) { create(:diary, user: user) }
		let!(:diary2) { create(:diary, user: user2) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
		end
		describe '日記投稿のテスト' do
			context '投稿画面への遷移' do
				it '遷移できる' do
					visit new_diary_path
					expect(current_path).to eq('/diaries/new')
				end
			end
			before do
				visit new_diary_path
			end
			context '表示の確認' do
				it 'New Diaryと表示される' do
					expect(page).to have_content 'New Diary'
				end
				it 'titleフォームが表示される' do
					expect(page).to have_field 'diary[title]'
				end
				it 'opinionフォームが表示される' do
					expect(page).to have_field 'diary[body]'
				end
				it 'Create Diaryボタンが表示される' do
					expect(page).to have_button 'Create Diary'
				end
				it '投稿に成功する' do
					fill_in 'diary[title]', with: Faker::Lorem.characters(number:5)
					fill_in 'diary[body]', with: Faker::Lorem.characters(number:20)
					click_button 'Create Diary'
					expect(page).to have_content 'successfully'
				end
				it '投稿に失敗する' do
					click_button 'Create Diary'
					expect(page).to have_content 'error'
					expect(current_path).to eq('/diaries')
				end
			end
		end
	end
	describe '編集のテスト' do
		let(:user) { create(:user) }
		let!(:user2) { create(:user) }
		let!(:diary) { create(:diary, user: user) }
		let!(:diary2) { create(:diary, user: user2) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
		end
		context '自分の投稿編集画面への遷移' do
			it '遷移できる' do
				visit edit_diary_path(diary)
				expect(current_path).to eq('/diaries/' + diary.id.to_s + '/edit')
			end
		end
		context '他人の投稿の編集画面への遷移' do
			it '遷移できない' do
				visit edit_diary_path(diary2)
				expect(current_path).to eq('/diaries')
			end
		end
		before do
			visit edit_diary_path(diary)
		end
		context '表示の確認' do
			it 'Edit Diaryと表示される' do
				#binding.pry
				expect(page).to have_content('Edit Diary')
			end
			it 'title編集フォームが表示される' do
				expect(page).to have_field 'diary[title]', with: diary.title
			end
			it 'body編集フォームが表示される' do
				expect(page).to have_field 'diary[body]', with: diary.body
			end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_diary_path(diary)
				click_button 'Update Diary'
				expect(page).to have_content 'successfully'
				expect(current_path).to eq('/diaries/' + diary.id.to_s)
			end
			it '編集に失敗する' do
				visit edit_diary_path(diary)
				fill_in 'diary[title]', with: ''
				click_button 'Update Diary'
				expect(page).to have_content 'error'
				expect(current_path).to eq('/diaries/' + diary.id.to_s)
			end
		end
	end
	describe '一覧のテスト' do
		let(:user) { create(:user) }
		let!(:user2) { create(:user) }
		let!(:diary) { create(:diary, user: user) }
		let!(:diary2) { create(:diary, user: user2) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
			visit diaries_path
		end
		context '表示の確認' do
			it 'Diary Indexと表示される' do
				expect(page).to have_content 'Diary Index'
  			end
  			it '自分と他人のオピニオンが表示される' do
  				expect(page).to have_content diary.title
  				expect(page).to have_content diary2.title
  			end
  			it '自分と他人のタイトルのリンク先が正しい' do
  				expect(page).to have_link diary.title, href: diary_path(diary)
  				expect(page).to have_link diary2.title, href: diary_path(diary2)
  			end
  		end
  	end

  	describe '詳細のテスト' do
  		let(:user) { create(:user) }
		let!(:user2) { create(:user) }
		let!(:diary) { create(:diary, user: user) }
		let!(:diary2) { create(:diary, user: user2) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log In'
			visit diary_path(diary)
		end
  		context '自分・他人共通の投稿詳細画面の表示を確認' do
  			it '投稿のtitleが表示される' do
  				visit diary_path(diary)
  				expect(page).to have_content diary.title
  			end
  			it '投稿のbodyが表示される' do
  				visit diary_path(diary)
  				expect(page).to have_content diary.body
  			end
  		end
  		context '他人の投稿詳細画面の表示を確認' do
  			it '投稿の編集リンクが表示されない' do
  				visit diary_path(diary2)
  				expect(page).to have_no_link 'Destroy', href: diary_path(diary2)
  			end
  		end
  	end
end