require 'test_helper'
require 'capybara/rails'
require 'forgery'

class EventFlowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    # Set up a user and his organization
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    @some_org = organizations(:coord_one)
    @some_org.members.add_member(@user, admin_flag: true)    
  end

  test "Creating an Event" do
    capybara_sign_in(@user)
    some_org = Organization.first
    visit new_organization_event_path(some_org)
    fill_in 'Name for this event', with: Forgery::Name.full_name + "1"
    fill_in 'Location of event', with: "New Orleans"
 
    click_link_or_button('Save')
    assert page.has_content?('Event was successfully created.'), "Flash message should tell you success"
    # Teams and Members Tabs show
    assert page.has_link?('Teams'), "Teams tab should be visible"
    assert page.has_link?('Members'), "Members tab should be visible"
  end

  test "Events with Members disallowed, should hide the member tab" do
    capybara_sign_in(@user)
    some_org = Organization.first
    visit new_organization_event_path(some_org)    
    fill_in 'Name for this event', with: Forgery::Name.full_name + "2"
    fill_in 'Location of event', with: "New Orleans"
    uncheck 'event_members_allowed'
    click_link_or_button('Save')
    assert page.has_no_link?('Members'), "Members tab should be hidden"
  end

  test "Events with Teams disallowed, should hide the team tab" do
    capybara_sign_in(@user)
    some_org = Organization.first
    visit new_organization_event_path(some_org)    
    fill_in 'Name for this event', with: Forgery::Name.full_name + "2"
    fill_in 'Location of event', with: "New Orleans"
    uncheck 'event_teams_allowed'
    click_link_or_button('Save')
    assert page.has_no_link?('Teams'), "Teams tab should be hidden"
  end

########################################################################## 
#########################    webkit tests    #############################
########################################################################## 
  test "Max Members section hides and shows correctly" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist 
 
    capybara_sign_in(@user)
    visit new_organization_event_path(@some_org)
    # default visible
    assert page.has_content?('Max members'), "Max Members should be visible by default"
    assert find_field('event_members_allowed').checked?

    # hide it
    uncheck 'event_members_allowed'
    #should be hidden
    assert page.has_no_content?('Max members'), "Max members should be hidden"
    check 'event_members_allowed'
    #shows again
    assert page.find_field('event_max_members').visible?

    Capybara.use_default_driver 
  end


  test "Max Teams section hides and shows correctly" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist 
    capybara_sign_in(@user)
    visit new_organization_event_path(@some_org)
    # default visible and checked
    assert page.find_field('event_max_teams').visible?
    assert page.find_field('event_max_team_size').visible?
    assert find_field('event_teams_allowed').checked?

    # hide it
    uncheck 'event_teams_allowed'
    #should be hidden
    assert page.has_no_content?('Maximum teams')
    assert page.has_no_content?('Max team size')
    check 'event_teams_allowed'
    #shows again
    assert page.find_field('event_max_teams').visible?
    assert page.find_field('event_max_team_size').visible?
    Capybara.use_default_driver 
  end


  test "All No Max checkboxes work as desired" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist

  
    capybara_sign_in(@user)
    visit new_organization_event_path(@some_org)

    message = ""
    test_value = "5"
  
    # verify what we want is visible
    max_members = page.find_field('event_max_members')
    max_teams = page.find_field('event_max_teams')
    max_teams_size = page.find_field('event_max_team_size')

    # should be read only
    fill_in 'Max members', with: test_value
    fill_in 'Max teams', with: test_value
    fill_in 'Max team size', with: test_value
    message = "Readonly field should be blank"
    assert max_members.value.blank?, message
    assert max_teams.value.blank?, message
    assert max_teams_size.value.blank?, message

    # remove readonly and try now?
    uncheck 'event_max_membersno-max'
    uncheck 'event_max_teamsno-max'
    uncheck 'event_max_team_sizeno-max'
    fill_in 'Max members', with: test_value
    fill_in 'Max teams', with: test_value
    fill_in 'Max team size', with: test_value
    message = "Should be the filled in value now"
    assert max_members.value == test_value, message
    assert max_teams.value == test_value, message
    assert max_teams_size.value == test_value, message

    # nulls out value when checked
    check 'event_max_membersno-max'
    check 'event_max_teamsno-max'
    check 'event_max_team_sizeno-max'
    message = "Should be forced blank"
    assert max_members.value.blank?, message
    assert max_teams.value.blank?, message
    assert max_teams_size.value.blank?, message

    Capybara.use_default_driver 
  end


end
