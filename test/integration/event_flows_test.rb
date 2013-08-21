require 'test_helper'
require 'capybara/rails'
require 'forgery'

class EventFlowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    # Set up a user and his organization
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    @some_season = seasons(:season_one)
    @some_org = @some_season.organization
    @some_org.members.add_member(@user, admin_flag: true)    
  end
  
  test "certain index buttons require login" do
    visit organization_season_events_path(@some_org, @some_season)
    assert page.has_no_link?("New Event"), "Shouldn't have a new button"
    assert page.has_no_link?("Edit"), "Shouldn't have a edit button"
    assert page.has_no_link?("Delete"), "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    capybara_sign_in(@user)
    visit organization_season_events_path(@some_org, @some_season)
    assert page.has_link?("New Event"), "Should have a new button"
    assert page.has_link?("Edit"), "Should have a edit button"
    assert page.has_link?("Delete"), "Should have a delete button"
  end

  test "Creating an Event" do
    capybara_sign_in(@user)
    visit new_organization_season_event_path(@some_org, @some_season)
    fill_in 'Name for this event', with: Forgery::Name.full_name + "1"
    fill_in 'Location of event', with: "New Orleans"
 
    click_link_or_button('Save')
    assert page.has_content?('Event was successfully created.'), "Flash message should tell you success"
    # Teams and Members Tabs show
    assert @some_season.teams_allowed?, "Make sure this fixture allows teams"
    assert page.has_link?('Teams'), "Teams tab should be visible"
    assert @some_season.members_allowed?, "Make sure this fixture allows memebrs"
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
