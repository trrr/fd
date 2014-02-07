class PostsController < ApplicationController

  # I still don't like this very much. Mostly the fact what we have to perform
  # search with dummy data when no parameters are given. Will think of it later.

  def index
    @posts = Post.get_posts_by_params(categories_ids, params[:page], params[:per_page], timepoint, up_or_down)
    render json: @posts.as_json(only: [:id, :message, :picture, :updated_time, :category_id, :author_id])
  end

  private

    def timepoint
      params['action']['id'] ? Post.find(params['action']['id']).updated_time : "2000-01-01T00:00:00.000Z"
    end

    def up_or_down
      params['action']['behavior'] == 'down' ? '<' : '>'
    end

    def categories_ids
      params[:tag_id] || Category.pluck(:id)
    end
end
