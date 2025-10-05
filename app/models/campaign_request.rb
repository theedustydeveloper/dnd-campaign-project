class CampaignRequest < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :campaign

  # Enums
  enum :status, { pending: 0, approved: 1, rejected: 2 }

  # Validations
  validates :user_id, uniqueness: { scope: :campaign_id, message: "has already requested to join this campaign" }
  validates :status, presence: true

  # Scopes
  scope :pending_requests, -> { where(status: :pending) }
  scope :for_campaign, ->(campaign_id) { where(campaign_id: campaign_id) }

  # Methods
  def approve!
    update(status: :approved)
  end

  def reject!
    update(status: :rejected)
  end
end
