class AddGpgKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gpg_key, :text
    add_index :users, :name, unique: true
  end
end
