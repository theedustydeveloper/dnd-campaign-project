class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role enum
  enum :role, { player: 0, game_master: 1, admin: 2 }

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  # Associations
  has_many :owned_campaigns, class_name: "Campaign", foreign_key: "game_master_id", dependent: :destroy
  has_many :campaign_requests, dependent: :destroy

  # Role helper methods
  def admin?
    role == "admin"
  end

  def game_master?
    role == "game_master"
  end

  def player?
    role == "player"
  end
end
