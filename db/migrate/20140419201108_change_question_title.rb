class ChangeQuestionTitle < ActiveRecord::Migration
  def up
    Question.find_each do |q|
      if q.content =~ /\*\*(.*?)\*\*/
        q.update_attribute(:title, $1[0..254])
      else
        q.update_attribute(:title, q.content[0..25])
      end
    end
  end

  def down
    # no op, please reload from yml
  end
end
