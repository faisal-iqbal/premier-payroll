module ApplicationHelper
  def clear_flash
    %w(notice warning error).each do |msg|
      unless flash[msg.to_sym].blank?
        flash[msg.to_sym] = ''
      end
    end
  end
  
  def get_working_days(d1, d2)
    diff = d2 - d1
    diff - holidays(d1, d2)
  end
  
  def holidays(d1, d2)
    holidays = 0
    ret = (d2-d1).divmod(7)
    holidays =  ret[0].truncate * wdays.length
    d1 = d2 - ret[1]
    while(d1 <= d2)
      if wdays.include?(d1.wday)
        holidays += 1
      end
      d1 += 1
    end
    holidays
  end
  
  def tax(salary)
    salary*0.1
  end

  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end
      else
        html << "<h5>#{message}</h5>"
      end
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end  
end
