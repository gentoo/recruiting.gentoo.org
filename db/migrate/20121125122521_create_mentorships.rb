class CreateMentorships < ActiveRecord::Migration
  def up
    create_table :mentorships, id: false do |t|
      t.integer :mentor_id
      t.integer :candidate_id
    end
  end

  def down
    drop_table :mentorships
  end
end
