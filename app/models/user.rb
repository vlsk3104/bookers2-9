class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates :name, presence: true, length: {minimum: 2,maximum: 20}
  validates :introduction, length: {maximum: 50}
  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

# 都道府県を番号に変換する
  
  # フォロー機能
  #フォローする　user.follower.id(relationshipモデルで定義されたfollowerクラス)=follower_id
  has_many :follower,class_name: "Relationship" ,foreign_key:"follower_id",dependent: :destroy
  #フォローされる user.followed.id = followed_id
  has_many :followed,class_name: "Relationship" ,foreign_key:"followed_id",dependent: :destroy
  #自分がactive,passiveユーザーを取得 follower_idと同じレコードのfollowed_idの取得
  has_many :following_user, through: :follower, source: :followed
  #自分がpassive,activeユーザーを取得 followed_idと同じレコードのfollower_idの取得
  has_many :follower_user,through: :followed, source: :follower
# follower_idにfollower(current_user)のuser_id、followed_idにfind(params:user_id)が入る
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
     following_user.include?(user)
  end
end
