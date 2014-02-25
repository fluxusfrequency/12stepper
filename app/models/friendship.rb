class Friendship < ActiveRecord::Base
  include InvalidatesCache unless ENV['TRAVIS']
  validates_presence_of :user_id, :friend_id, :status
  validates_inclusion_of :status, in: %w(pending approved)
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }

end
