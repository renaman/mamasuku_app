class Admin::DiariesController < ApplicationController
	before_action :authenticate_admin!
	def index
		@user = User.find(params[:user_id])
		@diaries = @user.diaries.page(params[:page]).order(created_at: :desc).per(15)
	end

	def show
		@diary = Diary.find(params[:id])
	end

	def destroy
		@diary = Diary.find(params[:id])
		@diary.destroy
		redirect_to admin_user_diaries_path, notice: "successfully deleted diary!"
	end

	def diary_params
		params.require(:diary).permit(:title, :body)
	end

end
