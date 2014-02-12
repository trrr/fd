class PostsController < ApplicationController


  def index
    if params["id"]
      timepoint = Post.find(params['id']).updated_time
      up_or_down = params['behavior'] == 'down' ? '<' : '>'     
    end

    @posts = Post.get_posts_by_params(params[:categories_ids], params[:per_page], timepoint, up_or_down)
    render json: @posts
  end
end
