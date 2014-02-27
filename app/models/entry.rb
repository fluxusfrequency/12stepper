class Entry < ActiveRecord::Base
  belongs_to :user


  def to_status
    (self.title.html_safe + " - " + self.body.html_safe).gsub(/(\<p\>|\<\/p\>)/, "").gsub("&#39;", "'")
  end

end
