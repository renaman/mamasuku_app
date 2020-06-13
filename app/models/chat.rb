class Chat < ApplicationRecord
	belongs_to :user
	belongs_to :room
	has_one :notification, dependent: :destroy

end
