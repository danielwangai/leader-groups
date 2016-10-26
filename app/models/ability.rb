class Ability
  include CanCan::Ability

  def initialize(user)

    guest = User.new
    guest.role = Role.new
    guest.role.role_name = "Regular"
    user ||= guest # Guest user

    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
