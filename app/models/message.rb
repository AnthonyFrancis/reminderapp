class Message < ApplicationRecord
	#validates :from, presence: true
	validates :to, presence: true
  	validates :text, presence: true

  	belongs_to :user

  	scope :draft, 		->{ where(published_at: nil)}
  	scope :published, 	->{ where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  	scope :scheduled,	->{ where.not(published_at: nil).where("published_at > ?", Time.zone.now) }
end
