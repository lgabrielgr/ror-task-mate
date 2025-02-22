module TeamsHelper
  CSS_CARD_TEXT_CLASS = "card-text".freeze

  def ticket_card(ticket)
    content_tag(:a, href: ticket_view_path(id: ticket.id), class: "text-decoration-none text-dark") do
      content_tag(:div, class: "card mb-3 shadow-sm") do
        content_tag(:div, class: "card-body", style: "height: 170px;") do
          content_tag(:h5, truncate(ticket.title, length: 22, omission: "..."), class: "card-title") +
            content_tag(:p, "Assignee: #{ticket.assignee_name}", class: CSS_CARD_TEXT_CLASS) +
            content_tag(:p, "Due date: #{ticket.due_date} #{ticket.due_date < Date.today ? '&#128680;'.html_safe : ''}".html_safe, class: CSS_CARD_TEXT_CLASS, style: "font-size: smaller; margin-top: -10px;") +
            content_tag(:p, content_tag(:span, ticket.priority_emoticon.html_safe, title: "#{ticket.human_readable_priority} Priority"), class: CSS_CARD_TEXT_CLASS, style: "font-size: smaller; margin-top: -10px;")
        end
      end
    end
  end
end
