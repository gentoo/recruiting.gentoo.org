class AddRecruitedToReadyUser < ActiveRecord::Migration
  def change
    add_column :ready_users, :recruited, :boolean, default: false
  end
end
