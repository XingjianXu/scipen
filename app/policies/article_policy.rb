class ArticlePolicy < ApplicationPolicy

  def create?
    update?
  end

  def update?
    return false if @user.blank?
    if @record.homepage?
      @user.admin?
    else
      SpacePolicy.new(@user, @record.space).update?
    end
  end

  def show?
    if @record.space.present?
      SpacePolicy.new(@user, @record.space).show?
    else
      true
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
