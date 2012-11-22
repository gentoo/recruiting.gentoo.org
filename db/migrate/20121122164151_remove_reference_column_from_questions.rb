class RemoveReferenceColumnFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :reference
  end
end
