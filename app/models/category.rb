class Category < ActiveRecord::Base
  has_many :authors
  validates :name, presence: true
end
