class Author < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :category
end
