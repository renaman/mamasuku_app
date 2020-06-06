class User::FavoritesController < ApplicationController

	def create
		@diary = Diary.find(params[:diary_id])
		favorite = @diary.favorites.new(user_id: current_user.id)
		favorite.save
	end

	def destroy
		@diary = Diary.find(params[:diary_id])
		favorite = current_user.favorites.find_by(diary_id: @diary.id)
		favorite.destroy
	end
end
