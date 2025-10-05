class CampaignPolicy < ApplicationPolicy
  def index?
    true # Anyone can view campaigns list
  end

  def show?
    true # Anyone can view campaign details
  end

  def create?
    user.game_master? || user.admin?
  end

  def update?
    user.admin? || record.game_master_id == user.id
  end

  def destroy?
    user.admin? || record.game_master_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
