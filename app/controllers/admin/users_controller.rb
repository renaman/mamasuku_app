class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.is_active == "true"
			@user.update(is_active: false)
		else
			@user.update(is_active: true)
		end
		if @user.update(user_params)
		   redirect_to admin_user_path(@user), notice: "successfully updated user!"
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :postal_code, :prefecture_code, :city, :street, :is_active)
	end

end
