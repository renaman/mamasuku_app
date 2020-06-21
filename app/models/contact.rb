class Contact < ApplicationRecord
	belongs_to :user

	validates :name, presence: true, length: {maximum: 20}
	validates :email, presence: true
	validates :message, presence: true, length: {maximum: 200}
end
