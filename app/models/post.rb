class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :board

  has_many :comments
end
