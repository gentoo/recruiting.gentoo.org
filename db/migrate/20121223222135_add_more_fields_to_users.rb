class AddMoreFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ssh_key, :text
    add_column :users, :address, :string
    add_column :users, :skills, :string
    add_column :users, :other_skills, :string
    add_column :users, :projects, :string
  end
end
