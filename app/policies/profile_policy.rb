class ProfilePolicy < ApplicationPolicy

  def update?
    return false if @user.blank?
    @user.admin? || @user == @record.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
