class User::DiariesController < ApplicationController
	before_action :authenticate_user!

	def new
		@diary = Diary.new
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		if @diary.save
			redirect_to diaries_path
		else
			render :new
		end
	end

	def index
		@diaries = Diary.page(params[:page]).reverse_order
		@user = current_user
	end

	def show
		@diary = Diary.find(params[:id])
		@user = @diary.user
		@diary_comment = DiaryComment.new
		@diary_comments = @diary.diary_comments
	end

	def edit
		@diary = Diary.find(params[:id])
	end

	def update
		@diary = Diary.find(params[:id])
		if @diary.update(diary_params)
			redirect_to diary_path(@diary)
		else
			render :edit
		end
	end

	def destroy
		@diary = Diary.find(params[:id])
		@diary.destroy
		redirect_to diaries_path
	end

	private

	def diary_params
		params.require(:diary).permit(:title, :body, :image, :remove_image)
	end


end
