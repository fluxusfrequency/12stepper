class CreateBigBookChapters < ActiveRecord::Migration
  def change
    create_table :big_book_chapters do |t|
      t.string :title
      t.text :body
      t.integer :chapter_number
    end
  end
end
