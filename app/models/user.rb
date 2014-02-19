class User < ActiveRecord::Base
  has_secure_password

  validates :username, :email, presence: true
  validates_uniqueness_of :email

  has_many :entries

  def days_of_sobriety
    "15 days"
  end
end
