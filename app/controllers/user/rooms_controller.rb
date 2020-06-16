class User::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_room, only: [:show]

	def create
    	@room = Room.create
    	UserRoom.create(room_id: @room.id, user_id: current_user.id)
    	user_room = UserRoom.new(room_params)
    	user_room.room_id = @room.id
    	user_room.save
    	redirect_to room_path(@room)
  	end

	def show
    	@room = Room.find(params[:id])
    	user_room = @room.user_rooms.where.not(user_id: current_user.id).take
    	@user = user_room.user
    	# => の記述を書き換える
    	if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      		@chats = @room.chats.page(params[:page]).reverse_order.per(10)
      		@chat = Chat.new(room_id: @room.id)
      		@user_rooms = @room.user_rooms
    	else
      		redirect_to root_path
    	end
  	end

  	private
  	def room_params
  		params.require(:user_room).permit(:user_id)
  	end

    def screen_room
      @room = Room.find(params[:id])
      unless current_user && @room.user_rooms.where.not(user_id: current_user.id).take
        redirect_to root_path
      end
    end
end
