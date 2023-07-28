class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Post
      can :create, Comment
      can :update, Post, author_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
    end
  end
end
