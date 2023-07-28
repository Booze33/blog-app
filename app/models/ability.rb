# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Post
      can :update, Post, author_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
    end
  end
end
