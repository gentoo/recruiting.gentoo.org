class AddDefaultValueToAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :status
    add_column :answers, :workflow_state, :string
    remove_column :questions, :approved
    add_column :questions, :workflow_state, :string
  end
end
