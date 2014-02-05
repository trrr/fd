class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def tags 
    @tags = Category.all
    render json: @tags.as_json
  end

  def posts
    categories_ids = params[:tag_id] || Category.all.map(&:id)
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @posts = Post.where("category_id in (?)", categories_ids).page(page).per(per_page)

    up_or_down = params['action']['behavior'] || 'up'

    render json: @posts
  end

end
