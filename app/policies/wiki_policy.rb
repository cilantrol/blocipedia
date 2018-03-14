class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?; true; end
  def create? ; user.present? ; end
  def new? ; create? ; end
  def destroy? ; user.present? ; end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if !user.present? || user.standard?
        scope.where(private: false)
      elsif user.admin? || user.premium?
        # return all wikis
        wikis = scope.all
      elsif user.standard?
        scope.where(private: false)
      end
    end
  end

end
