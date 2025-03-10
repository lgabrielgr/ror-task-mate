module Constants
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
end
