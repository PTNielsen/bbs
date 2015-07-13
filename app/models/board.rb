class Board < ActiveRecord::Base
  belongs_to :moderator, class_name: "User"

  has_many :posts
end
