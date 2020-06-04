class User::UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path(@user)
	end

	def leave
	end

	def hide
		@user = current_user
		@user.update(is_active: false)
		reset_session
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :age, :profile_image, :introduction, :remove_profile_image)
	end

end
