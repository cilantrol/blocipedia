class WikiPolicy < ApplicationPolicy

  def show?   ; true; end
  def new? ; create? ; end
  def create? ; true; end
  def update? ; record.user == user || user.role == "admin" || record.user == 'gaowhui@gmail.com' ; end
  def destroy?; record.user == user || user.role == "admin" || record.user == 'gaowhui@gmail.com'; end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  # def index
  #   user.present?
  # end

  # def new?
  #   user.present?
  # end

  # def create?
  #   user.present?
  # end

  # def show?
  #   user.present?
  # end

  # def update?
  #   user.present?
  # end

  # def destroy?
  #   wiki_owner? || user.role == "admin"
  # end

  # private

  # def wiki_owner?
  #   record.user == user
  # end

end
