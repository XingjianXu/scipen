class SpacePolicy < ApplicationPolicy

  def update?
    @user == @record.user
  end

  def create?
    @user.present?
  end

  def show?
    case @record.visibility
      when 'personal'
        @record.user == @user
      when 'trusted'
        @user.present?
      when 'unrestricted'
        true
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
