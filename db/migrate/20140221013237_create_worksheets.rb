class CreateWorksheets < ActiveRecord::Migration
  def change
    create_table :worksheets do |t|
      t.string :title
      t.text :body
      t.string :locale
      t.integer :step
      t.timestamps
    end
  end
end
