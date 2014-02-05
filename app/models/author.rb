class Author < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :category
  after_save :fetch_posts

  private 
    def fetch_posts
      Resque.enqueue(PostsFetcher, self.id)
    end
end
