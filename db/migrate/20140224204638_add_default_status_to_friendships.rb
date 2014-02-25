class AddDefaultStatusToFriendships < ActiveRecord::Migration
  def change
    change_column :friendships, :status, :string, default: "pending"
  end
end
