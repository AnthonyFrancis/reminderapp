class Message < ApplicationRecord
	#validates :from, presence: true
	validates :to, presence: true
  	validates :text, presence: true

  	belongs_to :user
end
