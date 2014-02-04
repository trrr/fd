class Author < ActiveRecord::Base
  has_many :author_categories
  has_many :categories, through: :author_categories
  has_many :posts
end
