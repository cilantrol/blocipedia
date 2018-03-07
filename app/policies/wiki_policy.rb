class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?; true; end
  def create? ; user.present? ; end
  def new? ; create? ; end

  def destroy?
    user.present?
  end

  class Scope < Scope
    attr_reader :user, :wiki

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present?
        @scope.all
      end
    end
  end

end
