class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.candidate?
      can :manage, [Question, Comment]
      can :create, Answer
      can :update, Answer
      can :read, Answer
      cannot :destroy, Comment
    elsif user.mentor?
      can :manage, [Question, Answer, Comment]
      can :sponsor, User
      cannot :destroy, Comment
    elsif user.recruiter?
      can :manage, [Question, Answer, Group, Comment]
      can :promote, User
      can :sponsor, User
      cannot :destroy, Comment
    elsif user.admin?
      can :manage, :all
      cannot :apply, Project
    elsif user.developer?
      can :apply, Project
      can :create, Question
      can :read, :all
    elsif user.novice? 
      can :apply, Project
    else
      can :read, :all
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
