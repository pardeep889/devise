class UserMailer < ApplicationMailer
	def contact_mail(data)
    @data = data
    #@url  = # generate confirmation url
    mail(to: @data.email, subject: "new subject message")
  end
end
