class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  #controls permissions CRUD
  def show?; true; end
  def create? ; user.present? ; end
  def update? ; wiki.user == user ; end
  def edit? ; update? ; end
  def new? ; create? ; end
  def destroy? ; user.present? ; end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

  #controls authorization views
    def resolve
      wikis = []
      if !user.present?
        return scope.where(private: false)
      elsif user.admin?
        # return all wikis
        wikis = scope.all
      elsif user.premium?
      # if the user is premium, only show them public wikis, or that private wikis they created,
      # or private wikis they are a collaborator on
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      elsif user.standard?
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
        # only show standard users public wikis and private wikis they are a collaborator on
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki
           end
        end
      end
      wikis
    end
  end

end
