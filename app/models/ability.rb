# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    # #
    # if user
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    # else
    #   can :read, :all
    # end

  end
end
