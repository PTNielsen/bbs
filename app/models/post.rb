class Post < ActiveRecord::Base
  belongs_to :author
  belongs_to :board

  has_many :comments
end
