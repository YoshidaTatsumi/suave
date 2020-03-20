class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.user_id = current_user.id
		if @contact.save
			ContactMailer.send_when_create(current_user, @contact).deliver_now
			flash[:notice] = "お問い合わせを送信しました"
			redirect_to root_path
		else
			flash[:danger] = "入力ミスがあります"
			render 'new'
		end
	end

	private
	def contact_params
		params.require(:contact).permit(:user_id, :title, :content)
	end
end
