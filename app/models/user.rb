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
      event :recruit, transitions_to: :staffer
    end

    state :staffer do
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
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :questions, through: :groups

  has_and_belongs_to_many :mentors, class_name: "User", join_table: "mentorships",
    foreign_key: "mentor_id", association_foreign_key: "candidate_id"
  has_and_belongs_to_many :sponsees, class_name: "User", join_table: "mentorships",
    foreign_key: "candidate_id", association_foreign_key: "mentor_id"

  has_many :ready_users # only for join

  scope :candidates, where(workflow_state: :candidate)
  scope :ready, joins(:ready_users).where("ready_users.user_id = users.id")

  validates_presence_of :email, :name
  #validates_presence_of :ssh_key, :gpg_key, on: :update

  validates_uniqueness_of :name

  has_many :comments, dependent: :delete_all

  before_validation :sluggish_name

  def answer_for(question)
    Answer.for(self, question).first
  end

  def answers_waiting_review
    Answer.reviewable(self).awaiting_review
  end

  def assigned_to?(question)
    question.group_id.in? group_ids
  end

  def recruit(candidate)
    sponsees << candidate
  end

  def mentoring?(candidate)
    sponsees.include?(candidate)
  end

  # Figure out a ready user from all the users is too much work, I don't mind waste
  # a little space.
  def get_ready!(group)
    ReadyUser.create(user_id: id, group_id: group.id)
  end

  def ready_for?(group)
    group.questions.count == answers.where(question_id: group.questions, workflow_state: "accepted").count
  end

  def ready?
    ! ready_users.empty?
  end

  def progress
    @progress ||= ( answers.select(&:accepted?).count / Question.for_user(self).count.to_f ).round(2)
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

  def to_param
    name
  end

  private
  def sluggish_name
    self.name = self.name.downcase.gsub(/\s+/, '-')
  end
end
