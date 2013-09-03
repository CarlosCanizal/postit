module ApplicationHelper

  def fix_url(url)
    url.starts_with?('http') ? url : "http://#{url}" 
  end

  def date_format(date)
    date.in_time_zone(current_user.time_zone).strftime("%d %B %Y %H:%M:%S")
  end

end
