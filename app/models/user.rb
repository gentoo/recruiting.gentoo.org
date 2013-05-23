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
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :questions, through: :groups

  has_and_belongs_to_many :mentors, class_name: "User", join_table: "mentorships",
    foreign_key: "mentor_id", association_foreign_key: "candidate_id"
  has_and_belongs_to_many :sponsees, class_name: "User", join_table: "mentorships",
    foreign_key: "candidate_id", association_foreign_key: "mentor_id"

  has_one :ready_user # only for join

  scope :candidates, where(workflow_state: :candidate)
  scope :ready, joins(:ready_user).where("ready_users.user_id = users.id")

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
  def get_ready!
    ReadyUser.create(user_id: id)
  end

  def ready?
    # reorder('') is necessary - for some reason "ORDER BY created_at" gets
    # added to scopes automatically and causes problems when running query over
    # more than one table with the column

    uid = Question.sanitize self.id
    questions_in_group_count  = Question.
                                  where("questions.group_id = groups.id").
                                  select('COUNT(questions.id)').
                                  reorder('')
    answered_questions_count = questions_in_group_count.
                                  joins(%{
                                    INNER JOIN answers ON
                                      answers.question_id = questions.id
                                      AND
                                      answers.user_id = #{uid}
                                  })
    # Groups selected by user
    user_selected = Group.
                      joins(%{
                        INNER JOIN user_groups ON
                        user_groups.group_id = groups.id
                        AND
                        user_groups.user_id = #{uid}
                      })

    # And from them we choose those that have the same number of questions as
    # number of questions answered. That is they have all questions answered
    solved_groups = user_selected.where(%{
      (#{questions_in_group_count.to_sql})
      =
      (#{answered_questions_count.to_sql})
    }).
    reorder('')

    # User is ready if there is at least one group with all questions answered
    solved_groups.any?
  end

  def progress
    @progress ||= ( answers.select(&:accepted?).count / Question.for_user(self).count.to_f )
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
