class CampaignRequestPolicy < ApplicationPolicy
  def create?
    user.player? || user.admin?
  end

  def update?
    # Only the campaign's game master or admin can approve/reject requests
    user.admin? || record.campaign.game_master_id == user.id
  end

  def destroy?
    # Users can cancel their own requests, or game masters can remove them
    user.admin? || record.user_id == user.id || record.campaign.game_master_id == user.id
  end

  def approve?
    update?
  end

  def reject?
    update?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.game_master?
        # Game masters can see requests for their campaigns
        scope.joins(:campaign).where(campaigns: { game_master_id: user.id })
      else
        # Players can only see their own requests
        scope.where(user_id: user.id)
      end
    end
  end
end
