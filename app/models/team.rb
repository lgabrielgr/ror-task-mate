class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"

  validates :name, presence: true

  def tickets
    Ticket.where(team: self)
  end

  def is_team_member?(user)
    members.include?(user)
  end
end
