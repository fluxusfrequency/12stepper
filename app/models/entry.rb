class Entry < ActiveRecord::Base
  belongs_to :user


  def to_status
    (self.title.html_safe + "\n" + self.body.html_safe[0, 500]).gsub(/(\<p\>|\<\/p\>)/, "").gsub("&#39;", "'")
  end

end
