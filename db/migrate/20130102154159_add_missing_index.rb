class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :users, :group_id
    add_index :mentorships, [:candidate_id, :mentor_id]
    add_index :mentorships, [:mentor_id, :candidate_id]
    add_index :questions, :group_id
    add_index :answers, :user_id
    add_index :answers, :question_id
    add_index :answers, :operator_id
  end
end
