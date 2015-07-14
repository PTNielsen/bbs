class Ability
  
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
        can :manage, :all
    else 
        can :read, :all? 
    end

    can :read, Board
    can :read, Post
    can :create, Post

    can [:update, :destroy], Post, author_id: user.id
    can [:update, :destroy], Comment, author_id: user.id
  end

end