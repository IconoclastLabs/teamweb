module EventsHelper
  def badge(word, count)
    "#{word} <span class='badge badge-info'>#{count}</span>".html_safe
  end 

end
