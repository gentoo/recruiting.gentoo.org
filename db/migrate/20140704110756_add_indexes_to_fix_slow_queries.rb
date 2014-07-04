class AddIndexesToFixSlowQueries < ActiveRecord::Migration
  def change
    add_index :users, :workflow_state

    add_index :answers, :workflow_state
    add_index :answers, [:user_id, :question_id]

    remove_index :answers, :user_id
    remove_index :answers, :question_id
  end
end
