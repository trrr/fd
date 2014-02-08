class Post < ActiveRecord::Base
  default_scope { order('updated_time DESC') }
  before_save :set_category
  belongs_to :author


  def self.get_posts_by_params(categories_ids, page = 1, per_page = 10, time, more_or_less)
    Post.select(:id, :message, :picture, :updated_time, :category_id, :author_id)
            .where("category_id IN (?) AND updated_time #{more_or_less} (?)", categories_ids, time)
            .page(page)
            .per(per_page)
  end

  private
    def set_category
      self.category_id = self.author.category_id
    end
end
