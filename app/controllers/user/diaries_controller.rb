class User::DiariesController < ApplicationController
	before_action :authenticate_user!
	before_action :screen_diary, only: [:update, :edit]

	def new
		@diary = Diary.new
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		if @diary.save
			redirect_to diaries_path, notice: "successfully created diary!"
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
		@diary_comments = @diary.diary_comments.page(params[:page]).reverse_order.per(5)
	end

	def edit
		@diary = Diary.find(params[:id])
	end

	def update
		@diary = Diary.find(params[:id])
		if @diary.update(diary_params)
			redirect_to diary_path(@diary), notice: "successfully updated diary!"
		else
			render :edit
		end
	end

	def destroy
		@diary = Diary.find(params[:id])
		@diary.destroy
		redirect_to diaries_path, notice: "successfully deleted diary!"
	end

	private

	def diary_params
		params.require(:diary).permit(:title, :body, :image, :remove_image)
	end

	def screen_diary
		diary = Diary.find(params[:id])
		if diary.user != current_user
			redirect_to diaries_path
		end
	end


end
