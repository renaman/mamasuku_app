class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms


  def follow(user_id)
  	follower.create(followed_id: user.id)
  end

  def unfollow(user_id)
  	follower.find_by(followed_id: user.id)
  end

  def following(user)
  	following_user.include?(user)
  end

  def active_for_authentication?
  	super && self.is_active
  end

end
