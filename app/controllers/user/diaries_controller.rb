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
		@diaries = Diary.all
		@user = current_user
	end

	def show
		@diary = Diary.find(params[:id])
		@user = @diary.user
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

	private

	def diary_params
		params.require(:diary).permit(:title, :body, :image, :remove_image)
	end


end
