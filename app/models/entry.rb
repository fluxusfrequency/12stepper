class Entry < ActiveRecord::Base
  belongs_to :user


  def to_status
    (self.title + "\n" + self.body).gsub(/(\<p\>|\<\/p\>)/, "")
  end

end
