class User::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :screen_user, only: [:update, :edit]

	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries.page(params[:page]).reverse_order
		@current_user_rooms = UserRoom.where(user_id: current_user.id)
		@user_user_rooms = UserRoom.where(user_id: @user.id)

		unless @user.id == current_user.id
			@current_user_room_ids = UserRoom.where(user_id: current_user.id).select(:room_id)
			@target_room = UserRoom.find_by(user_id: @user.id, room_id: @current_user_room_ids)
			
			if @target_room == nil
				@is_room = false
				@room = Room.new
				@user_room = UserRoom.new
			else 
				@is_room = true
				@room_id = @target_room.room_id			
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(@user), notice: "successfully updated user!"
		else
			render action: :edit
		end
	end

	def leave
	end

	def hide
		@user = current_user
		@user.update(is_active: false)
		reset_session
		redirect_to root_path, notice: "You have withdrawn!"
	end

	private
	def user_params
		params.require(:user).permit(:name, :age, :profile_image, :introduction, :remove_profile_image)
	end

	def screen_user
		if params[:id].to_i != current_user.id
			redirect_to user_path(current_user)
		end
	end

end
