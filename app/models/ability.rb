class Ability
  include CanCan::Ability

  def initialize(user)

    guest = User.new
    guest.role = Role.new
    guest.role.role_name = "Regular"
    user ||= guest # Guest user

    if user.admin?
      can :manage, Archive
      can :manage, User
      can :manage, Group
      can :read, Report
      can :read, Member
      can :manage, Broadcast
    else
      can :manage, Member
      can :manage, Report
      can :read, Archive
      can :read, Group
      can :read, Broadcast
    end
  end
end
