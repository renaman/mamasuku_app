class Admin::ContactsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@contacts = Contact.page(params[:page]).order(created_at: :desc).per(15)
	end

	def edit
		@contact = Contact.find(params[:id])
	end

	def update
		contact = Contact.find(params[:id])
		contact.update(contact_params)
		user = contact.user
		ContactMailer.send_when_admin_reply(user, contact).deliver_now
		redirect_to admin_top_path, notice: "successfully sent mail!"
	end

	private
	def contact_params
		params.require(:contact).permit(:name, :email, :message, :reply)
	end	
end
