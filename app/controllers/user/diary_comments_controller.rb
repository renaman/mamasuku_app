class User::DiaryCommentsController < ApplicationController

	def create
		@diary = Diary.find(params[:diary_id])
		@diary_comment = @diary.diary_comments.new(diary_comment_params)
		@diary_comment.user_id = current_user.id
		if @diary_comment.save
			flash[:notice] = "Comment was successfully created."
			redirect_to diary_path(@diary.id)
		else
			@diary_comments = DiaryComment.where(diary_id: @diary.id)
			render '/diaries/show'
		end
	end

	def destroy
		@diary = Diary.find(params[:diary_id])
		@diary_comment = DiaryComment.find(params[:diary_comment_id])#user_idがnilと言われたのでparamsにuser_idを入れた
		print(params)
		print(current_user)
		if @diary_comment.user != current_user
			redirect_to request_referer
		end
		@diary_comment.destroy
		redirect_to diary_path(@diary.id)
	end

	private

	def diary_comment_params
		params.require(:diary_comment).permit(:comment)
	end
end
