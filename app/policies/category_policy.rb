class CategoryPolicy < ApplicationPolicy

  def create?
    update?
  end

  def update?
    return false if @user.blank?
    @user.admin?
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
