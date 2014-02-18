class BigBook::Chapter < ActiveRecord::Base
  validates_presence_of :title, :body, :chapter_number
end