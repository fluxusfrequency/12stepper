class AddLastDrinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_drink, :datetime
  end
end
