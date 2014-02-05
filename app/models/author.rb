class Author < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :category
  before_save :fetch_posts
  
  private 
    def fetch_posts
      PostsFetcher.fetch_and_save_author_posts(self)
    end
end
