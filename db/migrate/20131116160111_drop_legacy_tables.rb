class DropLegacyTables < ActiveRecord::Migration
  def up
    drop_table :categories
    drop_table :categories_users

    drop_table :groups_projects
    drop_table :groups_users

    drop_table :projects
    drop_table :projects_users
  end

  def down
  end
end
