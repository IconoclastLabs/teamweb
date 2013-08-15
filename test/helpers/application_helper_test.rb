require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def test_icon_tag
    icon_html = icon_tag("play")
    assert_match "<i class='icon-play icon-white'></i> ", icon_html
  end

  def test_black_icon
    icon_html = black_icon("play")
    assert_match "<i class='icon-play'></i> ", icon_html
  end
end
