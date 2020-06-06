class User::SearchController < ApplicationController
	before_action :authenticate_user!
	def search
		@search = Diary.search(params[:q])
		@diaries = @search.result
	end

end
