class PostsController < ApplicationController


  def index
    if params["id"]
      timepoint = Post.find(params['id']).updated_time
      before_or_after = params['behavior'] == 'down' ? '<' : '>'     
    end

    @posts = Post.api_data.
                          category_in(params[:categories_ids]).
                          posted_at(before_or_after, timepoint).
                          limit(params[:per_page] || 10)

    render json: @posts
  end
end
