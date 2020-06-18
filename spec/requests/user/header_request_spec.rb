require 'rails_helper'

describe 'ヘッダーのテスト' do
  	describe 'ログインしていない場合' do
    	before do
      		visit root_path
  		end
  		context 'ヘッダーの表示を確認' do
  			subject { page }
  			it 'Topリンクが表示される' do
  				top_link = find_all('a')[0].native.inner_text
  				expect(top_link).to match(/Top/i)
  			end
  			it 'Aboutリンクが表示される' do
        		about_link = find_all('a')[1].native.inner_text
        		expect(about_link).to match(/About/i)
    		end
    		it 'Sign Upリンクが表示される' do
        		signup_link = find_all('a')[2].native.inner_text
        		expect(signup_link).to match(/Sign Up/i)
        	end
        	it 'Log Inリンクが表示される' do
        		login_link = find_all('a')[3].native.inner_text
        		expect(login_link).to match(/Log In/i)
        	end
 		end
 		context 'ヘッダーのリンクを確認' do
      		subject { current_path }
      		it 'Top画面に遷移する' do
        		top_link = find_all('a')[0].native.inner_text
        		click_link top_link
        		is_expected.to eq(root_path)
      		end
      		it 'About画面に遷移する' do
        		about_link = find_all('a')[1].native.inner_text
        		click_link about_link
        		is_expected.to eq(homes_about_path)
      		end
      		it 'Sign Up画面に遷移する' do
        		signup_link = find_all('a')[2].native.inner_text
        		click_link signup_link
        		is_expected.to eq(new_user_registration_path)
      		end
      		it 'Log In画面に遷移する' do
        		login_link = find_all('a')[3].native.inner_text
        		click_link login_link
        		is_expected.to eq(new_user_session_path)
      		end
    	end
  	end
  	describe 'ログインしている場合' do
    	let(:user) { create(:user) }
    	before do
      		visit new_user_session_path
      		fill_in 'user[email]', with: user.email
      		fill_in 'user[password]', with: user.password
      		click_button 'Log In'
    	end
    	context 'ヘッダーの表示を確認' do
      		subject { page }
      		it 'Diaryリンクが表示される' do
        		diary_link = find_all('a')[0].native.inner_text
        		expect(diary_link).to match(/Diary/i)
      		end
      		it 'Newリンクが表示される' do
        		new_link = find_all('a')[1].native.inner_text
        		expect(new_link).to match(/New/i)
      		end
      		it 'My Pageリンクが表示される' do
        		mypage_link = find_all('a')[2].native.inner_text
        		expect(mypage_link).to match(/My Page/i)
      		end
      		it 'Log Outリンクが表示される' do
        		logout_link = find_all('a')[3].native.inner_text
        		expect(logout_link).to match(/log Out/i)
      		end
      	end

      	context 'ヘッダーのリンクを確認' do
      		subject { current_path }
      		it 'Diary画面に遷移する' do
        		diary_link = find_all('a')[0].native.inner_text
        		click_link diary_link
        		is_expected.to eq('/diaries')
      		end
      		it 'New画面に遷移する' do
        		new_link = find_all('a')[1].native.inner_text
        		click_link new_link
        		is_expected.to eq('/diaries/new')
      		end
      		it 'My Page画面に遷移する' do
        		mypage_link = find_all('a')[2].native.inner_text
        		click_link mypage_link
        		is_expected.to eq('/users/' + user.id.to_s)
      		end
      		it 'log Outする' do
        		logout_link = find_all('a')[3].native.inner_text
        		click_link logout_link
        		expect(page).to have_content 'Signed out successfully.'
      		end
    	end
    end
end
