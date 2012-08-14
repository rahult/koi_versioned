class Post < ActiveRecord::Base
  is_versioned
  has_many :comments
end
