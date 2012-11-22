class User < ActiveRecord::Base
  include Workflow
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role
  # attr_accessible :title, :body

  workflow do
    state :novice do
      event :promote, transitions_to: :candidate
    end

    state :candidate do
      event :promote, transitions_to: :developer
      event :reject, transitions_to: :novice
    end

    state :developer do
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
  has_many :questions
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :projects

  belongs_to :mentor, class_name: "User"
  has_many :sponsees, class_name: "User", foreign_key: :mentor_id

  scope :novices, where(workflow_state: :novice)

  validates_presence_of :email, :name, :password

  def answer_for(question)
    Answer.for(self, question).first
  end

  def answers_waiting_review
    Answer.awaiting_review.joins(:user).where("users.id" => sponsees.map(&:id))
  end

  def recruit(novice)
    sponsees << novice
    novice.promote!
  end
end
