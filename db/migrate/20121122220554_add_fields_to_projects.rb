class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :parent_prj_id, :integer
    add_column :projects, :leader_id, :integer
  end
end
