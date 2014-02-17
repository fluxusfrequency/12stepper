class RemoveTexts < ActiveRecord::Migration
  def change
    drop_table :texts
  end
end
