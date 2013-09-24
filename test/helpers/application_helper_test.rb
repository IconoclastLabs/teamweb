require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

	describe "icon_tag method alias" do
	  it "renders a white icon_tag for bootstrap" do
	    icon_tag("play").must_match "<i class='glyphicon glyphicon-play'></i>"
	  end
	end

	describe "black_icon method alias" do
    it "renders black icon_tag for bootstrap" do
      black_icon_tag("play").must_match "<i class='glyphicon glyphicon-play'></i>"
  	end
  end

  describe "bootstrap icon tag test" do
    it "renders a white icon_tag for bootstrap" do
      bs_icon_tag("play").must_match "<i class='glyphicon glyphicon-play'></i>"
    end
  end

  describe "bootstrap black icons tag test" do
    it "renders black icon_tag for bootstrap" do
      bs_black_icon_tag("play").must_match "<i class='glyphicon glyphicon-play'></i>"
    end
  end

  describe "Font-Awesome icon tag test" do
    it "renders a white icon_tag for bootstrap" do
      fa_icon_tag("play").must_match "<i class='icon-play icon-white'></i>"
    end
  end

  describe "Font-Awesome black icon tag test" do
    it "renders black icon_tag for bootstrap" do
      fa_black_icon_tag("play").must_match "<i class='icon-play'></i>"
    end
  end
end
