class Question < ActiveRecord::Base
  include Workflow

  acts_as_commentable

  attr_accessible :content, :id, :title, :user_id, :group_id, :category_id
  has_many :answers
  belongs_to :user
  belongs_to :category
  belongs_to :group

  validates_presence_of :title, :content, :category, :group

  workflow do
    state :new do
      event :approve, transitions_to: :approved
      event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

  default_scope -> {
    where(workflow_state: :approved)
  }

  scope :unanswered_by, -> user {
    Question.where(group_id: user.groups.map(&:id)).where("id NOT IN (SELECT question_id FROM answers INNER JOIN users ON users.id = answers.user_id)")
  }

  scope :answered_by, -> user {
    joins(:answers).where("answers.user_id = ?", user.id).group(:group_id)
  }

  def category_name
    category.name
  end

end
