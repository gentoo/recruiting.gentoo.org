class AddTeamToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :team, :string
  end
end
