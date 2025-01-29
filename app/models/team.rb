class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"

  validates :name, presence: true

  def owner
    User.find(owner_id)
  end
end
