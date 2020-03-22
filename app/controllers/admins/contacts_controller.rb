class Admins::ContactsController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		if params[:support] == "today"
			@contacts = Contact.where(created_at: Time.now.in_time_zone("Tokyo").beginning_of_day..Time.now.in_time_zone("Tokyo").end_of_day).page(params[:page]).per(10).reverse_order
		elsif params[:support] == "not"
			@contacts = Contact.where(status: false).page(params[:page]).per(10).reverse_order
		else
			@contacts = Contact.all.page(params[:page]).per(10).reverse_order
		end
	end

	def show
		@contact = Contact.find(params[:id])
	end

	def update
		@contact = Contact.find(params[:id])
		if contact_params[:reply_content] == "" || contact_params[:reply_content].nil?
			flash[:danger] = "返信内容を入力してください"
			render "show"
		else
			@contact.status = true
			@contact.update(contact_params)
			ContactMailer.send_when_reply(@contact.user, @contact).deliver_now
			redirect_to admins_contacts_path
		end

	end

	def contact_params
		params.require(:contact).permit(:reply_content)
	end
end
