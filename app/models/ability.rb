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
    else
      can :read, :all
      can :manage, Member
      can :manage, Report
    end
  end
end
