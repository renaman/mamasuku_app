class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_ransack_diary

	def after_sign_up_path_for(resource)
		root_path
	end

	def after_sign_in_path_for(resource)
		case resource
		  when Admin
		  	admin_top_path
		  when User
		  	root_path
		 end
	end

	def after_sign_out_path_for(resource)
		case resource
		  when :admin
		  	admin_session_path
		  when :user
		  	root_path
		end
	end

	def set_ransack_diary
		@search = Diary.search(params[:q])
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :prefecture_code, :city, :street])
	end
end
