class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, presence: true
  validates_uniqueness_of :email
end
