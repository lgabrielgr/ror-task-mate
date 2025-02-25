class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :teams

  def friendly_name
    "#{first_name} (#{email})"
  end

  def teams_that_i_own
    Team.where("owner_id = ?", id)
  end

  def no_teams_assigned?
    teams.empty?
  end

  def can_see_team_tickets?(team)
    teams.include?(team) || team.owner_id == id
  end

  def can_see_ticket?(ticket)
    teams.include?(ticket.team) || ticket.team.owner_id == id
  end
end
