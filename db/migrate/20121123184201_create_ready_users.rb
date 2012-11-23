class CreateReadyUsers < ActiveRecord::Migration
  def change
    create_table :ready_users do |t|
      t.integer :user_id
    end
  end
end
