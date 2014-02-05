class Category < ActiveRecord::Base
  has_many :authors
end
