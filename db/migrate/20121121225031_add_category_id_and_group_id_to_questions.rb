class AddCategoryIdAndGroupIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :group_id, :integer
    add_column :questions, :category_id, :integer
  end
end
