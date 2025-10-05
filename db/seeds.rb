# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding database..."

# Create Admin user
admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.username = "admin"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
end
puts "Created Admin: #{admin.email}"

# Create Game Master users
gm1 = User.find_or_create_by!(email: "gm1@example.com") do |u|
  u.username = "dungeon_master_1"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :game_master
end
puts "Created Game Master: #{gm1.email}"

gm2 = User.find_or_create_by!(email: "gm2@example.com") do |u|
  u.username = "dungeon_master_2"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :game_master
end
puts "Created Game Master: #{gm2.email}"

# Create Player users
player1 = User.find_or_create_by!(email: "player1@example.com") do |u|
  u.username = "player_one"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :player
end
puts "Created Player: #{player1.email}"

player2 = User.find_or_create_by!(email: "player2@example.com") do |u|
  u.username = "player_two"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :player
end
puts "Created Player: #{player2.email}"

player3 = User.find_or_create_by!(email: "player3@example.com") do |u|
  u.username = "player_three"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :player
end
puts "Created Player: #{player3.email}"

# Create Campaigns
campaign1 = Campaign.find_or_create_by!(name: "Lost Mines of Phandelver") do |c|
  c.description = "A classic D&D adventure for new players. Explore the mines and uncover ancient secrets."
  c.game_master = gm1
  c.status = :active
end
puts "Created Campaign: #{campaign1.name}"

campaign2 = Campaign.find_or_create_by!(name: "Curse of Strahd") do |c|
  c.description = "A gothic horror adventure in the land of Barovia, ruled by the vampire Strahd von Zarovich."
  c.game_master = gm1
  c.status = :planning
end
puts "Created Campaign: #{campaign2.name}"

campaign3 = Campaign.find_or_create_by!(name: "Waterdeep: Dragon Heist") do |c|
  c.description = "An urban adventure in the City of Splendors, where treasure and danger await."
  c.game_master = gm2
  c.status = :active
end
puts "Created Campaign: #{campaign3.name}"

campaign4 = Campaign.find_or_create_by!(name: "Tomb of Annihilation") do |c|
  c.description = "A jungle adventure filled with dinosaurs, traps, and ancient curses."
  c.game_master = gm2
  c.status = :on_hold
end
puts "Created Campaign: #{campaign4.name}"

# Create Campaign Requests
request1 = CampaignRequest.find_or_create_by!(user: player1, campaign: campaign1) do |r|
  r.status = :approved
end
puts "Created Campaign Request: #{player1.username} -> #{campaign1.name} (approved)"

request2 = CampaignRequest.find_or_create_by!(user: player2, campaign: campaign1) do |r|
  r.status = :approved
end
puts "Created Campaign Request: #{player2.username} -> #{campaign1.name} (approved)"

request3 = CampaignRequest.find_or_create_by!(user: player3, campaign: campaign1) do |r|
  r.status = :pending
end
puts "Created Campaign Request: #{player3.username} -> #{campaign1.name} (pending)"

request4 = CampaignRequest.find_or_create_by!(user: player1, campaign: campaign3) do |r|
  r.status = :pending
end
puts "Created Campaign Request: #{player1.username} -> #{campaign3.name} (pending)"

request5 = CampaignRequest.find_or_create_by!(user: player2, campaign: campaign2) do |r|
  r.status = :rejected
end
puts "Created Campaign Request: #{player2.username} -> #{campaign2.name} (rejected)"

puts "\n✓ Seeding complete!"
puts "\nTest Users Created:"
puts "  Admin: admin@example.com / password123"
puts "  GM 1: gm1@example.com / password123"
puts "  GM 2: gm2@example.com / password123"
puts "  Player 1: player1@example.com / password123"
puts "  Player 2: player2@example.com / password123"
puts "  Player 3: player3@example.com / password123"
