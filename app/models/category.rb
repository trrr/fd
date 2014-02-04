class Category < ActiveRecord::Base
  has_many :author_categories
  has_many :authors, through: :author_categories
end
