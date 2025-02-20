class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :creator, class_name: "User"
  belongs_to :team
  has_many :comments, dependent: :destroy

  TICKET_TO_DO_STATUS = 0
  TICKET_IN_PROGRESS_STATUS = 1
  TICKET_REVIEW_STATUS = 2
  TICKET_DONE_STATUS = 3

  TICKET_TO_DO_STATUS_NAME = "To Do"
  TICKET_IN_PROGRESS_STATUS_NAME = "In Progress"
  TICKET_REVIEW_STATUS_NAME = "Review"
  TICKET_DONE_STATUS_NAME = "Done"

  TICKET_LOW_PRIORITY = 0
  TICKET_MEDIUM_PRIORITY = 1
  TICKET_HIGH_PRIORITY = 2

  TICKET_LOW_PRIORITY_NAME = "Low"
  TICKET_MEDIUM_PRIORITY_NAME = "Medium"
  TICKET_HIGH_PRIORITY_NAME = "High"

  TICKET_STATUS_OPTIONS = [ TICKET_TO_DO_STATUS, TICKET_IN_PROGRESS_STATUS, TICKET_REVIEW_STATUS, TICKET_DONE_STATUS ]
  TICKET_PRIORITY_OPTIONS = [ TICKET_LOW_PRIORITY, TICKET_MEDIUM_PRIORITY, TICKET_HIGH_PRIORITY ]

  validates :title, presence: true
  validates :status, inclusion: { in: TICKET_STATUS_OPTIONS }
  validates :priority, inclusion: { in: TICKET_PRIORITY_OPTIONS }

  def human_readable_priority
    case priority
    when TICKET_LOW_PRIORITY then TICKET_LOW_PRIORITY_NAME
    when TICKET_MEDIUM_PRIORITY then TICKET_MEDIUM_PRIORITY_NAME
    when TICKET_HIGH_PRIORITY then TICKET_HIGH_PRIORITY_NAME
    else "Unknown"
    end
  end

  def priority_emoticon
    case priority
    when TICKET_LOW_PRIORITY then "&#x1F634;"
    when TICKET_MEDIUM_PRIORITY then "&#x1F610;"
    when TICKET_HIGH_PRIORITY then "&#x1F525;"
    else "&#x2753;"
    end
  end

  def human_readable_status
    case status
    when TICKET_TO_DO_STATUS then TICKET_TO_DO_STATUS_NAME
    when TICKET_IN_PROGRESS_STATUS then TICKET_IN_PROGRESS_STATUS_NAME
    when TICKET_REVIEW_STATUS then TICKET_REVIEW_STATUS_NAME
    when TICKET_DONE_STATUS then TICKET_DONE_STATUS_NAME
    else "Unknown"
    end
  end

  def assignee_name
    assignee&.friendly_name || "Unassigned"
  end
end
