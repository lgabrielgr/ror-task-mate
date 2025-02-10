module TicketsHelper
  def form_group_select(f, field, options_for_selection, prompt)
    content_tag(:div, class: "form-group") do
      f.label(field, class: "form-label") +
        f.select(field, options_for_selection.map { |id, name| [name, id] }, { prompt: prompt }, class: "form-control")
    end
  end
end
