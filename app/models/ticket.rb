class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :team

  validates :title, presence: true
  validates :status, inclusion: { in: [ 0, 1, 2, 3 ] }
  validates :priority, inclusion: { in: [ 0, 1, 2 ] }

  def human_readable_priority
    case priority
    when 0 then "Low"
    when 1 then "Medium"
    when 2 then "High"
    else "Unknown"
    end
  end

  def priority_emoticon
    case priority
    when 0 then "&#x1F634;"
    when 1 then "&#x1F610;"
    when 2 then "&#x1F525;"
    else "&#x2753;"
    end
  end

  def human_readable_status
    case status
    when 0 then "To Do"
    when 1 then "In Progress"
    when 2 then "Review"
    when 3 then "Done"
    else "Unknown"
    end
  end

  def assignee_name
    assignee&.friendly_name || "Unassigned"
  end
end
