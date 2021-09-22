module ApplicationHelper
  def alert_class_for(flash_type)
    if flash_type == 'success' || flash_type == 'notice'
      'alert-success'
    else
      'alert-danger'
    end
  end

  def alertbox(klass,msg,icon = "check-circle")
    content_tag(:div,class: "alert #{klass} alert-dismissable") do
      link_to("x", "#", class: "close", "data-dismiss": "alert") +
        content_tag(:strong, msg)
    end
  end

  def humanize_date(date)
    date.try(:to_formatted_s, :long)
  end
end
