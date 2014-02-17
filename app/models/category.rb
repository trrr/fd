class Category < ActiveRecord::Base
  has_many :authors
  validates :name, presence: true
  scope :api_data, -> { select(:id, :name, :description) }
end
