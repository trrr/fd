class Post < ActiveRecord::Base
  default_scope { order('updated_time DESC') }
  before_save :set_category
  belongs_to :author


# TODO: Have to dry it up!!
  def self.get_previous(categories_ids, page, per_page, time)
    Post.where("category_id in (?)", categories_ids).where("updated_time < (?)", time).page(page).per(per_page)
  end

  def self.get_next(categories_ids, page, per_page, time)
    Post.where("category_id in (?)", categories_ids).where("updated_time > (?)", time).page(page).per(per_page)
  end

  private
    def set_category
      self.category_id = self.author.category_id
    end
end
