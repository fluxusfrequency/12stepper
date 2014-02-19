class BigBook::Chapter < ActiveRecord::Base
  validates_presence_of :title, :body, :chapter_number
  translates :title, :body
end