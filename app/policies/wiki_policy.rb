class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?   ; true; end

  def create?
    # p user
    # p "888888888"
    # p wiki
  # p record
    user.present?
    # true
  end

  def new? ; create? ; end

  def update?
    if user.present?
      user.role == "admin" || user.email == 'gaowhui@gmail.com'
    end
  end
  def destroy?
    if user.present?
      user.role == "admin" || user.email == 'gaowhui@gmail.com'
    end
  end
end
