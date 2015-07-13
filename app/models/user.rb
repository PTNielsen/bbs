class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, class_name: "Post", foreign_key: :author_id
  has_many :comments, class_name: "Comment", foreign_key: :author_id
  has_many :moderated_boards, class_name: "Board", foreign_key: :moderator_id
end
