class Author < ActiveRecord::Base
  has_many :posts
  belongs_to :category
  # has_many :authors_categories
  # has_many :categories, through: :authors_categories
end
