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

  end	

  def fb_callback
  	binding.pry
  end
end
