class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :teams

  def friendly_name
    first_name.present? ? "#{first_name}" : email
  end

  def teams_that_i_own
    Team.where("owner_id = ?", id)
  end
end
