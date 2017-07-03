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
        @graph = Koala::Facebook::API.new(current_user.token)
        @graph.put_connections("me", "feed", message: a)
        redirect_to "/post"
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
