class PostsController < ApplicationController

  def index
    @posts = Post.get_posts_by_params(categories_ids, params[:page], params[:per_page], timepoint, up_or_down)
    render json: @posts.as_json(only: [:id, :message, :picture, :updated_time, :category_id, :author_id])
  end

  private

    def timepoint
      given_id = params[:action][:id] || Post.last.id
      Post.find(given_id).updated_time
    end

    def up_or_down
      params[:action][:behavior] == 'down' ? '<' : '>'
    end

    def categories_ids
      params[:tag_id] || Category.all.map(&:id)
    end
end
