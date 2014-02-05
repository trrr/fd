class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def tags 
    @tags = Category.all
    render json: @tags.as_json
  end

  def posts
    @posts = Post.page(page) unless params[:tag_id]
    # @posts = Post.where("")
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    up_or_down = params['action']['behavior'] || 'up'

    
    render json: @posts
  end

end
