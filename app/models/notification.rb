class Notification < ApplicationRecord
	default_scope->{order(created_at: :desc)}

	belongs_to :chat
	belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id'
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end
