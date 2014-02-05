class Post < ActiveRecord::Base
  default_scope order('updated_time DESC')
  belongs_to :author
end
