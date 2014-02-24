class User < ActiveRecord::Base
  has_secure_password

  validates :username, :email, presence: true
  validates_uniqueness_of :username, :email

  has_many :entries
  has_many :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :friends, through: :friendships
  has_many :inverse_friends, through: :inverse_friendships, source: :user
end
