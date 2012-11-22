class AddDefaultValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, default: "candidate"
  end
end
