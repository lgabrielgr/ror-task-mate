class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friendly_name
    first_name.present? ? "#{first_name}" : email
  end
end
