class Status < ActiveRecord::Base
  validates_presence_of :content, :user_id
  belongs_to :user

  def ==(other)
    self.content == other.content && self.user_id == other.user_id
  end
end
