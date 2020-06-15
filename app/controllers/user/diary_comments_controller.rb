class User::DiaryCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@diary = Diary.find(params[:diary_id])
		@diary_comment = @diary.diary_comments.new(diary_comment_params)
		@diary_comment.user_id = current_user.id
		if @diary_comment.save
			flash[:notice] = "Comment was successfully created."
		else
			@diary_comments = DiaryComment.where(diary_id: @diary.id)
			render '/diaries/show'
		end
	end

	def destroy
		@diary = Diary.find(params[:diary_id])
		@diary_comment = DiaryComment.find(params[:id])#user_idがnilと言われたのでparamsにuser_idを入れた
		if @diary_comment.user != current_user
			redirect_to request_referer
		end
		@diary_comment.destroy
	end

	private

	def diary_comment_params
		params.require(:diary_comment).permit(:comment)
	end
end
