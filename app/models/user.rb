class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
   attr_accessor :name
   has_many :posts
   def name
   	"#{self.first_name} #{self.last_name}"
   end
   def self.from_omniauth(auth)
   #	binding.pry 
  	where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
	    user.email = "#{auth.uid}@{auth.provider}.com"
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.name   # assuming the user model has a name
      user.token = auth[:credentials][:token]   
      user.twitter_token = auth[:credentials][:token]   
      user.twitter_secret = auth[:credentials][:secret]   
	    user.confirm
	    #user.image = auth.info.image # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end
end
