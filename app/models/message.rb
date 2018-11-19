class Message < ApplicationRecord
	validates :to, presence: true
  	validates :from, presence: true
  	validates :text, presence: true

  	belongs_to :user
end
