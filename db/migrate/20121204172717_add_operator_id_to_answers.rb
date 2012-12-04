class AddOperatorIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :operator_id, :integer
  end
end
