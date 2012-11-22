class ChangeUserRoleToWorkflow < ActiveRecord::Migration
  def change
    remove_column :users, :role
    add_column :users, :workflow_state, :string
  end
end
