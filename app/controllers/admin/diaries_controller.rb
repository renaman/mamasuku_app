class Admin::DiariesController < ApplicationController
	before_action :authenticate_admin!
	def index
		@user = User.find(params[:user_id])
		@diaries = @user.diaries
	end

	def show
		@diary = Diary.find(params[:id])
	end

	def destroy
		@user = User.find(params[:user_id])
		@diary = Diary.find(params[:id])
		@diary.destroy
		redirect_to admin_diaries_path
	end

	def diary_params
		params.require(:diary).permit(:title, :body)
	end

end
