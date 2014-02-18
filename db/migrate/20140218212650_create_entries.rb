class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.references :user
      t.integer :step
      t.timestamps
    end
  end
end
