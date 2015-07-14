class Ability
  
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
        can :manage, :all
    else 
        can :read, :all
        can :create, Post
        can :create, Comment
    end

    can [:update, :destroy], Post, author_id: user.id
    can [:update, :destroy], Comment, author_id: user.id
  end

end