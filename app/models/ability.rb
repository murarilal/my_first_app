class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    if user.role == "admin"
      can :manage, :all

    else
      can :read, :all
      can :manage, Comment
    end
    if user.role == "author"
      can :manage, Comment 
      can :create, Article
      can :update, Article do |article|
        article.try(:user) == user
      end
    end
    if user.role == "owner"
      can :create, Product
    end  
  end  
end
