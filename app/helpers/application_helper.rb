module ApplicationHelper
  def fa_icon_tag(classname)
    raw "<i class='icon-#{classname} icon-white'></i> " #trailing space here is important
  end

  def fa_black_icon_tag(classname)
    raw "<i class='icon-#{classname}'></i> " #trailing space here is important
  end

  def bs_icon_tag(classname)
    raw "<i class='glyphicon glyphicon-#{classname}'></i> " #trailing space here is important
  end
  alias :icon_tag :bs_icon_tag

  def bs_black_icon_tag(classname)
    raw "<i class='glyphicon glyphicon-#{classname}'></i> " #trailing space here is important
  end
  alias :black_icon_tag :bs_black_icon_tag
end
