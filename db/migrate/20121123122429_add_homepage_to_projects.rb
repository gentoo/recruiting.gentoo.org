class AddHomepageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :homepage, :string
  end
end
