require 'rails_helper'

describe 'Adminヘッダーのテスト' do
  	describe 'ログインしていない場合' do
    	before do
      		visit new_admin_session_path
  		end
  		context 'ヘッダーの表示を確認' do
  			subject { page }
  			it 'Aboutリンクが表示される' do
  				about_link = find_all('a')[0].native.inner_text
  				expect(about_link).to match(/About/i)
  			end
  			it 'UserPageリンクが表示される' do
        	userpage_link = find_all('a')[1].native.inner_text
        	expect(userpage_link).to match(/UserPage/i)
    		end
        it 'LogInリンクが表示される' do
        	login_link = find_all('a')[2].native.inner_text
        	expect(login_link).to match(/LogIn/i)
        end
 		end
 		context 'ヘッダーのリンクを確認' do
      		subject { current_path }
      		it 'About画面に遷移する' do
        		about_link = find_all('a')[0].native.inner_text
        		click_link about_link
        		is_expected.to eq(homes_about_path)
      		end
      		it 'UserPage画面に遷移する' do
        		userpage_link = find_all('a')[1].native.inner_text
        		click_link userpage_link
        		is_expected.to eq(root_path)
      		end
      		it 'LogIn画面に遷移する' do
        		login_link = find_all('a')[2].native.inner_text
        		click_link login_link
        		is_expected.to eq(new_admin_session_path)
      		end
    	end
  	end
  	describe 'ログインしている場合' do
    	let(:admin) { create(:admin) }
    	before do
      		visit new_admin_session_path
      		fill_in 'admin[email]', with: admin.email
      		fill_in 'admin[password]', with: admin.password
      		click_button 'Log In'
    	end
    	context 'ヘッダーの表示を確認' do
      		subject { page }
      		it 'Topリンクが表示される' do
        		top_link = find_all('a')[0].native.inner_text
        		expect(top_link).to match(/Top/i)
      		end
      		it 'UserPageリンクが表示される' do
        		userpage_link = find_all('a')[1].native.inner_text
        		expect(userpage_link).to match(/UserPage/i)
      		end
      		it 'Contactリンクが表示される' do
        		contact_link = find_all('a')[2].native.inner_text
        		expect(contact_link).to match(/Contact/i)
      		end
      		it 'LogOutリンクが表示される' do
        		logout_link = find_all('a')[3].native.inner_text
        		expect(logout_link).to match(/logOut/i)
      		end
      	end

      	context 'ヘッダーのリンクを確認' do
      		subject { current_path }
      		it 'Top画面に遷移する' do
        		top_link = find_all('a')[0].native.inner_text
        		click_link top_link
        		is_expected.to eq('/admin/top')
      		end
      		it 'UserPage画面に遷移する' do
        		userpage_link = find_all('a')[1].native.inner_text
        		click_link userpage_link
        		is_expected.to eq('/admin/users')
      		end
      		it 'Contact画面に遷移する' do
        		contact_link = find_all('a')[2].native.inner_text
        		click_link contact_link
        		is_expected.to eq('/admin/contacts')
      		end
      		it 'logOutする' do
        		logout_link = find_all('a')[3].native.inner_text
        		click_link logout_link
        		expect(page).to have_content 'Signed out successfully.'
      		end
    	end
    end
end
