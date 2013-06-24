module ApplicationHelper
  def icon_tag(classname)
    raw "<i class='icon-#{classname} icon-white'></i> " #trailing space here is important
  end	
end
