require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  it "renders an icon_tag html" do
    icon_html = icon_tag("play")
    icon_html.must_equal "<i class='icon-play icon-white'></i> "
  end

  it "renders black_icon html" do
    icon_html = black_icon("play")
    icon_html.must_equal "<i class='icon-play'></i> "
  end
end
