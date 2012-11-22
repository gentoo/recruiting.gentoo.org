class Answer < ActiveRecord::Base
  include Workflow
  acts_as_commentable
  attr_accessible :content, :question_id, :status, :user_id, :user

  belongs_to :user
  belongs_to :question

  validates_presence_of :user, :question, :content

  scope :for, -> user, question {
    where(question_id: question.id).where(user_id: user.id)
  }

  workflow do
    state :awaiting_review do
      event :review, transitions_to: :being_reviewed
    end

    state :being_reviewed do
      event :accept, transitions_to: :accepted
      event :reject, transitions_to: :rejected
    end

    state :accepted
    state :rejected do
      event :submit, transitions_to: :awaiting_review
    end
  end
  
  def state
    current_state.to_s.humanize
  end
end
