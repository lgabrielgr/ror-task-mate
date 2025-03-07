class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"
  has_many :tickets, dependent: :destroy
  before_create :upcase_code_identifier

  validates :name, presence: true
  validates :code_identifier, presence: true, uniqueness: true, length: { maximum: 4 }

  def tickets
    Ticket.where(team: self)
  end

  def is_team_member?(user)
    members.include?(user) || owner == user
  end

  private

  def upcase_code_identifier
    self.code_identifier = code_identifier.upcase
  end
end
