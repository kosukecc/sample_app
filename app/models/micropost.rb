class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end

# class Micropost < ActiveRecord::Base
# 
#   belongs_to :user
#   default_scope -> { order('created_at DESC') }
#   validates :content, presence: true, length: { maximum: 140 }
#   validates :user_id, presence: true
#   
#   def create
#     @micropost = current_user.microposts.build(micropost_params)
#     if @micropost.save
#       flash[:success] = "Micropost created!"
#       redirect_to root_url
#     else
#       @feed_items = []
#       render 'static_pages/home'
#     end
#   end
#   
#   # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
#   def self.from_users_followed_by(user)
#     followed_user_ids = user.followed_user_ids
#     where("user_id IN (:followed_user_ids) OR user_id = :user_id",
#           followed_user_ids: followed_user_ids, user_id: user)
#   end
#   
# end