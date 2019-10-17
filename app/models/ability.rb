class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin_type == "admin"
      can :manage, Answer
      can :manage, Doubt
      can :manage, Question
      can :manage, Right
      can :manage, User
      can :manage, Complain
      can :read, ActiveAdmin::Page, name: 'Dashboard'
    else
      can :manage, Answer
      can :manage, Doubt
      can :manage, Question
      can :manage, Right
      can :read, ActiveAdmin::Page, name: 'Dashboard'
    end
  end

end