class TicketNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, ticket, action)
    Rails.logger.info("Sending ticket notification to #{user.email} for ticket #{ticket.id} related to action #{action}")
    case action
    when :updated
      TicketMailer.ticket_updated(user, ticket).deliver_later
    when :assigned
      TicketMailer.ticket_assigned(user, ticket).deliver_later
    else
      Rails.logger.error("Unknown action for ticket notification job: #{action}")
    end
  end
end
