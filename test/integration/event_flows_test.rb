require 'test_helper'
require 'capybara/rails'
require 'forgery'

class EventFlowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    # Set up a user and his organization
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    @some_org = organizations(:coord_one)
    @some_season = @some_org.seasons.first
    @some_org.members.add_member(@user, admin_flag: true)    
  end

  test "Creating an Event" do
    capybara_sign_in(@user)
    visit new_organization_season_event_path(@some_org, @some_season)
    fill_in 'Name for this event', with: Forgery::Name.full_name + "1"
    fill_in 'Location of event', with: "New Orleans"
 
    click_link_or_button('Save')
    assert page.has_content?('Event was successfully created.'), "Flash message should tell you success"
    # Teams and Members Tabs show
    #assert page.has_link?('Teams'), "Teams tab should be visible"
    assert page.has_link?('Members'), "Members tab should be visible"
  end

  # test "Events with Members disallowed, should hide the member tab" do
  #   capybara_sign_in(@user)
  #   visit new_organization_season_path(@some_org, @some_season)    
  #   fill_in 'Name for this event', with: Forgery::Name.full_name + "2"
  #   fill_in 'Location of event', with: "New Orleans"
  #   uncheck 'event_members_allowed'
  #   click_link_or_button('Save')
  #   assert page.has_no_link?('Members'), "Members tab should be hidden"
  # end

  # test "Events with Teams disallowed, should hide the team tab" do
  #   capybara_sign_in(@user)
  #   visit new_organization_season_event_path(@some_org, @some_season)    
  #   fill_in 'Name for this event', with: Forgery::Name.full_name + "2"
  #   fill_in 'Location of event', with: "New Orleans"
  #   uncheck 'event_teams_allowed'
  #   click_link_or_button('Save')
  #   assert page.has_no_link?('Teams'), "Teams tab should be hidden"
  # end

end
