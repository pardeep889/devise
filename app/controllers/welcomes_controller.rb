class WelcomesController < ApplicationController
 	before_action :authenticate_user!
  def index
       @post=Post.new

    #binding.pry
    # t=User.last.token
    #  require 'koala'
    #  @graph = Koala::Facebook::API.new(t)
    #  @graph.put_connections("me", "feed", message: "I am writing on my wall!")

  end
  def about
  	
  end
  def contact

  @mail = Contact.new
  end	

  def fb_callback
  	binding.pry
  end
  def create_contact
     @contact=Contact.new(contact_params)
     @contact.save
     UserMailer.contact_mail(@contact).deliver

#      binding.pry
      redirect_to "/", notice:  "Message Sent We Will Contact You Soon..."
  end

  def contact_params
     params.require(:contact).permit(:email, :subject,:message)
  end

end
