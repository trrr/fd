class PostsController < ApplicationController

# This is seriously ugly. 
# Basically what this crap does is sets defaults to passed arguments
# and asks Model for posts what fit given criteria.

  def index
    # Setting defaults.
    categories_ids = params[:tag_id] || Category.all.map(&:id)
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    from_id = params['action']['id'] || Post.last.id
    timepoint = Post.find(from_id).updated_time

    
    #Fetching post from db. TODO: Refactor this ASAP!
    @posts = if params['action']['behavior'] == 'down'
                      Post.get_previous(categories_ids, page, per_page, timepoint)
                    else
                      Post.get_next(categories_ids, page, per_page, timepoint)
                    end

    # sending posts to user
    render json: @posts.select!('id', 'message', 'picture', 'updated_time', 'category_id', 'author_id')
  end

end
