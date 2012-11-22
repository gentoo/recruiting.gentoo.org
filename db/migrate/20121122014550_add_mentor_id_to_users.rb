class AddMentorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mentor_id, :integer
  end
end
