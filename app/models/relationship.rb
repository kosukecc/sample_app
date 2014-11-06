class Relationship < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end