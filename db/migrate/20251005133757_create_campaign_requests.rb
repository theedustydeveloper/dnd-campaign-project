class CreateCampaignRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :campaign_requests, [:user_id, :campaign_id], unique: true
    add_index :campaign_requests, :status
  end
end
