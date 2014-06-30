class AddDeletedAtToModels < ActiveRecord::Migration
  def up
    add_column :answers, :deleted_at, :datetime
    add_column :questions, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
    add_column :groups, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_index :answers, :deleted_at
    add_index :questions, :deleted_at
    add_index :users, :deleted_at
    add_index :groups, :deleted_at
    add_index :comments, :deleted_at

    Answer.find_each do |answer|
      if answer.question.nil?
        answer.destroy
      end
    end
  end

  def down
    remove_column :answers, :deleted_at
    remove_column :questions, :deleted_at
    remove_column :users, :deleted_at
    remove_column :groups, :deleted_at
    remove_column :comments, :deleted_at
    remove_index :answers, :deleted_at
    remove_index :questions, :deleted_at
    remove_index :users, :deleted_at
    remove_index :groups, :deleted_at
    remove_index :comments, :deleted_at
  end

end
