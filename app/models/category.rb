class Category < ActiveRecord::Base
  has_many :authors

  # if author has many categories
  # has_many :authors_categories
  # has_many :authors, through: :authors_categories
end
