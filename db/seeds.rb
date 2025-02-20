LEO_USER_EMAIL = "leo.doe@test.com"
GABRIEL_USER_EMAIL = "gabriel.doe@test.com"
LULA_USER_EMAIL = "lula.doe@test.com"
ZULY_USER_EMAIL = "zuly.doe@test.com"

TEAM_RUBY_API_NAME_SAMPLE = "Ruby API"
TEAM_JAVA_API_NAME_SAMPLE = "Java API"

# Sample Users
User.create!(first_name: "Leo", last_name: "Doe", email: LEO_USER_EMAIL, password: "zaq12wsx", admin: true)
User.create!(first_name: "Gabriel", last_name: "Doe", email: GABRIEL_USER_EMAIL, password: "zaq12wsx")
User.create!(first_name: "Lula", last_name: "Doe", email: LULA_USER_EMAIL, password: "zaq12wsx")
User.create!(first_name: "Zuly", last_name: "Doe", email: ZULY_USER_EMAIL, password: "zaq12wsx")

# Sample Teams
Team.create!(name: TEAM_RUBY_API_NAME_SAMPLE, description: "Microservice serving as API in Ruby lang",
             owner_id: User.find_by(email: LEO_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |team|
  team.members << User.find_by(email: ZULY_USER_EMAIL)
  team.members << User.find_by(email: LEO_USER_EMAIL)
end
Team.create!(name: TEAM_JAVA_API_NAME_SAMPLE, description: "Microservice serving as API in Java lang",
             owner_id: User.find_by(email: LEO_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |team|
  team.members << User.find_by(email: GABRIEL_USER_EMAIL)
  team.members << User.find_by(email: LULA_USER_EMAIL)
  team.members << User.find_by(email: LEO_USER_EMAIL)
end

# Sample Tickets
Ticket.create!(title: "Implement basic auth", description: "Description of Ticket 1", status: 0,
               team_id: Team.find_by(name: TEAM_RUBY_API_NAME_SAMPLE).id, priority: 2, due_date: Date.new(2025, 9, 21),
               assignee_id: User.find_by(email: LEO_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |ticket|
  Comment.create!(body: "This is a sample comment 1", author: User.find_by(email: LEO_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 2", author: User.find_by(email: ZULY_USER_EMAIL), ticket: ticket)
end
Ticket.create!(title: "Project Scaffolding", description: "Description of Ticket 2", status: 1,
               team_id: Team.find_by(name: TEAM_RUBY_API_NAME_SAMPLE).id, priority: 2, due_date: Date.new(2025, 8, 14),
               assignee_id: User.find_by(email: ZULY_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |ticket|
  Comment.create!(body: "This is a sample comment 3", author: User.find_by(email: ZULY_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 4", author: User.find_by(email: ZULY_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 5", author: User.find_by(email: LEO_USER_EMAIL), ticket: ticket)
end
Ticket.create!(title: "Create endpoints to retrieve user information", description: "Description of Ticket 3", status: 0,
               team_id: Team.find_by(name: TEAM_JAVA_API_NAME_SAMPLE).id, priority: 1, due_date: Date.new(2025, 10, 10),
               assignee_id: User.find_by(email: LULA_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |ticket|
  Comment.create!(body: "This is a sample comment 6", author: User.find_by(email: GABRIEL_USER_EMAIL), ticket: ticket)
end
Ticket.create!(title: "Implement basic auth", description: "Description of Ticket 4", status: 0,
               team_id: Team.find_by(name: TEAM_JAVA_API_NAME_SAMPLE).id, priority: 2, due_date: Date.new(2025, 9, 29),
               assignee_id: User.find_by(email: GABRIEL_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |ticket|
  Comment.create!(body: "This is a sample comment 7", author: User.find_by(email: GABRIEL_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 8", author: User.find_by(email: LULA_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 9", author: User.find_by(email: LULA_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 10", author: User.find_by(email: GABRIEL_USER_EMAIL), ticket: ticket)
end
Ticket.create!(title: "Project Scaffolding", description: "Description of Ticket 5", status: 3,
               team_id: Team.find_by(name: TEAM_JAVA_API_NAME_SAMPLE).id, priority: 0, due_date: Date.new(2025, 9, 1),
               assignee_id: User.find_by(email: GABRIEL_USER_EMAIL).id, creator_id: User.find_by(email: LEO_USER_EMAIL).id).tap do |ticket|
  Comment.create!(body: "This is a sample comment 11", author: User.find_by(email: LEO_USER_EMAIL), ticket: ticket)
  Comment.create!(body: "This is a sample comment 12", author: User.find_by(email: LEO_USER_EMAIL), ticket: ticket)
end
