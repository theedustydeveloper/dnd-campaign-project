class DashboardController < ApplicationController
  def index
    @campaigns_count = Campaign.count
    @users_count = User.count
    @pending_requests_count = current_user.game_master? ?
      CampaignRequest.pending_requests.joins(:campaign).where(campaigns: { game_master_id: current_user.id }).count :
      0
  end
end
