require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

	describe "#icon_tag" do
	  it "renders a white icon_tag for bootstrap" do
	    icon_tag("play").must_match "<i class='icon-play icon-white'></i>"
	  end
	end

	describe "#black_icon" do
    it "renders black icon_tag for bootstrap" do
      black_icon("play").must_match "<i class='icon-play'></i>"
  	end
  end
end
