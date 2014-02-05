class Post < ActiveRecord::Base
  default_scope { order('updated_time DESC') }
  before_save :set_category
  belongs_to :author

  private
    def set_category
      self.category_id = self.author.category_id
    end
end
