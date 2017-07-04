class PostController < ApplicationController
  def index
    @posts=current_user.posts
  end

  def create
      a=params[:post][:title]
      current_user.posts
      current_user.posts.create(title: a)
      if current_user.token.blank?
        redirect_to root_path
      else
        begin
          @graph = Koala::Facebook::API.new(current_user.token)
          @graph.put_connections("me", "feed", message: a)

          client = Twitter::REST::Client.new do |config|
          config.consumer_key        = "E6aO6Z1zS5Jy79bLxdkZySX7g"
          config.consumer_secret     = "MFMsRHq51326gFCHlrogMQ8Xvczw7w1tR0qLhlwehI6kYAzq0P"
          config.access_token        = "852746782299705344-jggLKK7ptAsc19Z3cCCUZueSsivMRj6"
          config.access_token_secret = "2xFhmxW5LIUigDY19M1YiKkiZ5GepuRpUQImrLM4rmtZu"
          end
          client.update(a)
          redirect_to "/post"
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
