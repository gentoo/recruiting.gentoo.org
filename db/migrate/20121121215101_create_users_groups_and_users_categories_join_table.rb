class CreateUsersGroupsAndUsersCategoriesJoinTable < ActiveRecord::Migration
  def up
    create_table :groups_users, id: false do |t|
      t.integer :user_id
      t.integer :group_id
    end

    create_table :categories_users, id: false do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end

  def down
    drop_table :users_groups
    drop_table :users_categories
  end
end
