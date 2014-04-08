class Question < ActiveRecord::Base

  acts_as_commentable

  attr_accessible :content, :id, :title, :group_id, :group
  has_many :answers
  belongs_to :group
  has_many :user_groups, through: :group
  has_many :users, through: :user_groups

  default_scope order("created_at ASC")

  validates_presence_of :content, :group

  scope :for_user, -> user {
    joins(:users).where(['users.id = ?', user.id])
  }

  scope :unanswered_by, -> user {
    for_user(user).where('questions.id not in (select answers.question_id from answers where answers.user_id = ? and workflow_state in (?))', user.id, ['awaiting_review', 'accepted'])
  }

  scope :answered_by, -> user {
    joins(:answers).where("answers.user_id" => user.id)
  }

  scope :random, -> n { offset(rand(count)).limit(n) }

  def category_name
    group.name
  end

  def next
    self.class.where(group_id: group_id).where("id > ?", id).limit(1).first
  end

  def previous
    self.class.unscoped.where(group_id: group_id).order("id DESC").where("id < ?", id).limit(1).first
  end
end
