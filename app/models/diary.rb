class Diary < ApplicationRecord
	belongs_to :user
	attachment :image
	has_many :diary_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true, legth: {maximum: 20}
	validates :body, presence: true, legth: {maximum: 500}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
