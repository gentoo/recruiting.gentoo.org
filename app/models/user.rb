class User < ActiveRecord::Base
  include Workflow
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :biography, :workflow_state, :ssh_key, :date_of_birth, :address, :skills, :other_skills, :projects

  workflow do
    state :candidate do
      event :promote, transitions_to: :mentor
    end

    state :mentor do
      event :promote, transitions_to: :recruiter
    end

    state :recruiter do
      event :promote, transitions_to: :admin
    end

    state :admin
  end

  has_many :answers
  belongs_to :group

  has_and_belongs_to_many :mentors, class_name: "User", join_table: "mentorships", 
    foreign_key: "mentor_id", association_foreign_key: "candidate_id"
  has_and_belongs_to_many :sponsees, class_name: "User", join_table: "mentorships",
    foreign_key: "candidate_id", association_foreign_key: "mentor_id"

  has_one :ready_user # only for join

  scope :candidates, where(workflow_state: :candidate)
  scope :ready, joins(:ready_user).where("ready_users.user_id = users.id")

  validates_presence_of :email, :name
  validates_uniqueness_of :name

  has_many :comments, dependent: :delete_all

  def answer_for(question)
    Answer.for(self, question).first
  end

  def answers_waiting_review
    Answer.reviewable(self).awaiting_review
  end

  def assigned_questions
    Question.where(group_id: group_id)
  end

  def assigned_to?(question)
    question.group_id == group_id
  end

  def recruit(candidate)
    sponsees << candidate
  end

  def mentoring?(candidate)
    sponsees.include?(candidate)
  end

  # Figure out a ready user from all the users is too much work, I don't mind waste
  # a little space.
  def get_ready!
    ReadyUser.create(user_id: id)
  end

  def ready?
    assigned_questions.count == answers.count && answers.all?(&:accepted?)
  end

  def progress
    @progress ||= ( answers.select(&:accepted?).count / assigned_questions.count.to_f )
  end

  # mentor operations
  def accept!(answer)
    answer.accept!
    answer.mentor_action!(self)
  end

  def reject!(answer)
    answer.reject!
    answer.mentor_action!(self)
  end
end
