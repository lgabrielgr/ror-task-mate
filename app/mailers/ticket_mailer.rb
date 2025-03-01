class TicketMailer < ApplicationMailer
  def ticket_updated(user, ticket)
    send_notification(ticket, user, "Ticket Updated")
  end

  private

  def send_notification(ticket, user, subject)
    @user = user
    @ticket = ticket
    mail(to: @user.email, from: "no-reply@taskmate.com", subject:)
  end
end
