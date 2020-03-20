class ContactMailer < ApplicationMailer
	def send_when_create(user, contact)
		@user = user
		@contact = contact
	    mail to: user.email, subject: "[Suave]お問い合わせ送信のお知らせ"
	end

	def send_when_reply(user, contact)
		@user = user
		@contact = contact
	    mail to: user.email, subject: "[Suave]お問い合わせ頂いた件について"
	end
end
