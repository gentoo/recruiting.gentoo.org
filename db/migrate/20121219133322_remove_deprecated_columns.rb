class RemoveDeprecatedColumns < ActiveRecord::Migration
  def change
    remove_column :users, :applying_project_id
    remove_column :questions, :workflow_state
    remove_column :questions, :user_id
    remove_column :questions, :category_id
  end
end
