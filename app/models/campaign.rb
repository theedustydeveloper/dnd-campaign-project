class Campaign < ApplicationRecord
  # Associations
  belongs_to :game_master, class_name: "User"
  has_many :campaign_requests, dependent: :destroy
  has_many :requesting_players, through: :campaign_requests, source: :user

  # Enums
  enum :status, { planning: 0, active: 1, completed: 2, on_hold: 3 }

  # Validations
  validates :name, presence: true
  validates :status, presence: true

  # Scopes
  scope :active_campaigns, -> { where(status: :active) }
  scope :by_game_master, ->(user_id) { where(game_master_id: user_id) }
end
