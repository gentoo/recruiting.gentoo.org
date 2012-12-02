class Question < ActiveRecord::Base

  acts_as_commentable

  attr_accessible :content, :id, :title, :group_id, :group
  has_many :answers
  belongs_to :group
  default_scope order("created_at ASC")

  validates_presence_of :title, :content, :group

  scope :unanswered_by, -> user {
    where(group_id: user.group_id).where("id NOT IN (SELECT question_id FROM answers INNER JOIN users ON users.id = answers.user_id)")
  }

  scope :answered_by, -> user {
    joins(:answers).where("answers.user_id" => user.id)
  }

  scope :random, -> n { offset(rand(count)).limit(n) }

  def category_name
    group.name
  end

end
