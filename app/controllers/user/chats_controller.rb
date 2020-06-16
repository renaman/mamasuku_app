class User::ChatsController < ApplicationController
	before_action :authenticate_user!
	before_action :screen_chat, only: [:create]

	def create
		@chat = current_user.chats.new(chat_params)#チャット作成
		@chat.save
		notification = current_user.active_notifications.new(#notification作成
			chat_id: @chat.id,
			#チャットを作成した際にvisited_idがnilになっていたので取得方法を変更した。
			#サーバ側からvisited_idを取得、チャットルームのidをwhereで取得。チャットをポチッとした方じゃない方を探す処理
			#whereは複数形で返ってくるのでfirst.user_idで最新情報を探す
			visited_id: UserRoom.where(room_id:@chat.room_id).where.not(user_id:@chat.user_id).first.user_id,
			action: "chat"
		)
		notification.save
	end

	private
	def chat_params
		params.require(:chat).permit(:message, :room_id, :user_id)
	end

	def screen_chat
		unless current_user
			redirect_to root_path
		end
	end

end
