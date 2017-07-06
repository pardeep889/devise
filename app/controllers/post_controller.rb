class PostController < ApplicationController
  def index
    @posts=current_user.posts
  end

  def create
    a=params[:post][:title]
    b=params[:post][:image]
    
    current_user.posts.create(title: a, image: b)
    if current_user.token.blank?
      redirect_to root_path
    else
      begin
        if !current_user.provider.blank? && current_user.provider == "twitter"
          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "E6aO6Z1zS5Jy79bLxdkZySX7g"
            config.consumer_secret     = "MFMsRHq51326gFCHlrogMQ8Xvczw7w1tR0qLhlwehI6kYAzq0P"
            config.access_token        = current_user.twitter_token
            config.access_token_secret = current_user.twitter_secret
          end  
          client.update(a)
        end
        
        if !current_user.provider.blank? && current_user.provider == "facebook"
          @graph = Koala::Facebook::API.new(current_user.token)
          @graph.put_connections("me", "feed", message: a)
          redirect_to "/post", notice: "Post successfully."
        end

      rescue => e
         redirect_to "/post", notice: e.message
      end 
    end

  end

  def new
    @post=Post.new
    #binding.pry
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
