class Post < ActiveRecord::Base
  default_scope { order('updated_time DESC') }
  scope :api_data, -> {select(:id, :message, :picture, :updated_time, :category_id, :author_id)}
  scope :category_in, ->(categories_ids) {where(category_id: categories_ids) if categories_ids} 
  scope :posted_at, ->(before_or_after, time) {where("updated_time #{before_or_after} (?)", time) if time && before_or_after}
  before_save :set_category
  belongs_to :author
  validates :author, :message, :updated_time, presence: true

  def self.get_posts_by_params(categories_ids, per_page = 10, time=nil, before_or_after=nil)
    Post.api_data.category_in(categories_ids).posted_at(before_or_after, time).limit(per_page)
  end

  private
    def set_category
      self.category_id = self.author.category_id
    end
end
  