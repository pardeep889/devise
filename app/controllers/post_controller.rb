class PostController < ApplicationController
  def index
    @posts=current_user.posts
  end

  def create
    a=params[:post][:title]
    b=params[:post][:image]
    #binding.pry
    p=current_user.posts.create(title: a, image: b)
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
            
          # binding.pry
          if  p.image.blank?
                  client.update(a)
          else
              url = p.image[0].metadata["url"]
              img = open(url)
              if img.is_a?(StringIO)
                file_name = File.basename(url)
                temp_file = Tempfile.new(file_name)
                temp_file.binmode
                temp_file.write(img.read)
                temp_file.close

                t_img = temp_file.path
                client.update_with_media(a, t_img)
              else
                t_img = url
                client.update_with_media(a, open(t_img))
              end
          end
          redirect_to "/post", notice: "Post successfully."
        end
        
        if !current_user.provider.blank? && current_user.provider == "facebook"
          @graph = Koala::Facebook::API.new(current_user.token)
        if  p.image.blank?
            @graph.put_connections("me", "feed", {message: "a")
        else
          @graph.put_connections("me", "feed", {message: "a", picture: p.image[0].metadata["url"], link: p.image[0].metadata["url"]})
        end
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
