class User < ActiveRecord::Base
  include InvalidatesCache unless ENV['TRAVIS']
  has_secure_password

  validates :username, :email, :last_drink, presence: true
  validates_uniqueness_of :username, :email

  has_many :entries
  has_many :statuses

  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :friends, through: :friendships
  has_many :inverse_friends, through: :inverse_friendships, source: :user


  def days_sober
    diff = Time.now - last_drink.to_time
    return 1 if diff < 86400  
    diff.to_i / 86400
  end

  def approved_friends
    if ENV['TRAVIS']
      friends = []
      friends += self.friendships.approved.where(user_id: id).map {|friendship| friendship.friend}
      friends += self.inverse_friendships.approved.where(friend_id: id).map {|friendship| friendship.user}
      return friends
    end
    
    Rails.cache.fetch("approved_friends_for_#{self.username}") do
      friends = []
      friends += self.friendships.approved.where(user_id: id).map {|friendship| friendship.friend}
      friends += self.inverse_friendships.approved.where(friend_id: id).map {|friendship| friendship.user}
      friends
    end
  end

  def pending_friends
    friends = []
    friends += self.friendships.pending.where(user_id: id).map {|friendship| friendship.friend}
    friends += self.inverse_friendships.pending.where(friend_id: id).map {|friendship| friendship.user}
    friends
  end

  def all_friendships_and_inverse_friendships
    self.friendships + self.inverse_friendships
  end

  def is_friends_with?(other)
    self == other || self.approved_friends.include?(other)
  end

end
