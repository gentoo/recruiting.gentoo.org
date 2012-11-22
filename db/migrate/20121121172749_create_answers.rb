class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
