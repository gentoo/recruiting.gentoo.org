class AddGroupIdToReadyUsers < ActiveRecord::Migration
  def change
    add_column :ready_users, :group_id, :integer
    add_index :read_users, :user_id, :group_id, :uniq => true
  end
end
