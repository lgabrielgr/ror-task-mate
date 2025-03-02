class TicketMailer < ApplicationMailer
  def ticket_updated(user, ticket)
    send_notification(ticket, user, "Ticket updated: #{ticket.title}")
  end

  def ticket_assigned(user, ticket)
    send_notification(ticket, user, "Ticket assigned: #{ticket.title}")
  end

  private

  def send_notification(ticket, user, subject)
    @user = user
    @ticket = ticket
    mail(to: @user.email, subject:)
  end
end
