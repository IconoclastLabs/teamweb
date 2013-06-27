module ApplicationHelper
  def icon_tag(classname)
    raw "<i class='icon-#{classname} icon-white'></i> " #trailing space here is important
  end	

  def black_icon(classname)
    raw "<i class='icon-#{classname}'></i> " #trailing space here is important
  end	
end
