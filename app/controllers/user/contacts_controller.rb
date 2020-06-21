class User::ContactsController < ApplicationController
	before_action :authenticate_user!

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.user_id = current_user.id
		if @contact.save
			redirect_to contacts_thanks_path
		else
			render :new
		end
	end

	def thanks
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :message, :reply)
	end
end
