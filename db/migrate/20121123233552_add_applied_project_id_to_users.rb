class AddAppliedProjectIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :applying_project_id, :integer
  end
end
