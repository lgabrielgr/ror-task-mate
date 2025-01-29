# Sample Users
User.create!(first_name: "Leo", last_name: "Doe", email: "leo.doe@test.com", password: "zaq12wsx")
User.create!(first_name: "Gabriel", last_name: "Doe", email: "gabriel.doe@test.com", password: "zaq12wsx")
User.create!(first_name: "Lula", last_name: "Doe", email: "lula.doe@test.com", password: "zaq12wsx")
User.create!(first_name: "Zuly", last_name: "Doe", email: "zuly.doe@test.com", password: "zaq12wsx")

# Sample Teams
Team.create!(name: "Ruby API", description: "Microservice serving as API in Ruby lang", owner_id: User.find_by(email: "leo.doe@test.com").id).tap do |team|
  team.members << User.find_by(email: "zuly.doe@test.com")
end
Team.create!(name: "Java API", description: "Microservice serving as API in Java lang", owner_id: User.find_by(email: "leo.doe@test.com").id).tap do |team|
  team.members << User.find_by(email: "gabriel.doe@test.com")
  team.members << User.find_by(email: "lula.doe@test.com")
end
