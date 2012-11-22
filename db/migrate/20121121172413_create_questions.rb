class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :id
      t.string :title
      t.string :reference
      t.text :content
      t.integer :user_id
      t.boolean :approved

      t.timestamps
    end
  end
end
