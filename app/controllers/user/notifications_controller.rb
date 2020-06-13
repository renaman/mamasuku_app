class User::NotificationsController < ApplicationController

	def index
		@notifications = current_user.passive_notifications.page(params[:page]).per(10)
		@notifications.where(checked: false).each do |notification|#trueに更新する
            notification.update(checked: true)
        end
	end
end
