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
    
    # TODO: Refactor this ASAP!
    if params['action']['behavior'] == 'down'
      @posts = Post.where("category_id in (?)", categories_ids).where("updated_time < (?)", timepoint).page(page).per(per_page)
    else
      @posts = Post.where("category_id in (?)", categories_ids).where("updated_time > (?)", timepoint).page(page).per(per_page)
    end

    render json: @posts
  end

private

  def timepoint
    from_id = params['action']['id'] || Post.last.id
    Post.find(from_id).updated_time
  end
end
