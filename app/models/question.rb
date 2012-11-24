class Question < ActiveRecord::Base
  # FIXME seems group and category is duplicated
  include Workflow

  acts_as_commentable

  attr_accessible :content, :id, :title, :user_id, :group_id, :category_id
  has_many :answers
  belongs_to :user
  belongs_to :category
  belongs_to :group

  validates_presence_of :title, :content, :group

  workflow do
    state :pending do
      event :approve, transitions_to: :approved
      event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

  scope :valid, where(workflow_state: :approved)
  scope :pending, where(workflow_state: :pending)
  scope :trashed, where(workflow_state: :rejected)

  scope :unanswered_by, -> user {
    Question.valid.where(group_id: user.groups.map(&:id)).where("id NOT IN (SELECT question_id FROM answers INNER JOIN users ON users.id = answers.user_id)")
  }

  scope :answered_by, -> user {
    joins(:answers).where("answers.user_id = ?", user.id).group(:group_id)
  }

  scope :random, -> n { offset(rand(count)).limit(n) }

  def category_name
    group.name
  end

end
