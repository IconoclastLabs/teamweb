require 'test_helper'
require 'capybara/rails'
require 'forgery'

class SeasonFlowTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    # Set up a user and his organization
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    @some_org = organizations(:coord_one)
    @some_season = @some_org.seasons.first
    @some_org.members.add_member(@user, admin_flag: true)    
  end

########################################################################## 
#########################    Phantomjs tests    ##########################
########################################################################## 
  test "Max Members section hides and shows correctly" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist 
 
    capybara_sign_in(@user)
    visit new_organization_season_path(@some_org)
    # default visible
    assert page.has_content?('Max members'), "Max Members should be visible by default"
    assert find_field('season_members_allowed').checked?

    # hide it
    uncheck 'season_members_allowed'
    #should be hidden
    assert page.has_no_content?('Max members'), "Max members should be hidden"
    check 'season_members_allowed'
    #shows again
    assert page.find_field('season_max_members').visible?

    Capybara.use_default_driver 
  end


  test "Max Teams section hides and shows correctly" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist 
    capybara_sign_in(@user)
    visit new_organization_season_path(@some_org)
    # default visible and checked
    assert page.find_field('season_max_teams').visible?
    assert page.find_field('season_max_team_size').visible?
    assert find_field('season_teams_allowed').checked?

    # hide it
    uncheck 'season_teams_allowed'
    #should be hidden
    assert page.has_no_content?('Max teams')
    assert page.has_no_content?('Max team size')
    check 'season_teams_allowed'
    #shows again
    assert page.find_field('season_max_teams').visible?
    assert page.find_field('season_max_team_size').visible?
    Capybara.use_default_driver 
  end


  test "All No Max checkboxes work as desired" do
    # we need to see jQuery, so switch to more robust driver
    Capybara.current_driver = :poltergeist

  
    capybara_sign_in(@user)
    visit new_organization_season_path(@some_org)

    message = ""
    test_value = "5"
  
    # verify what we want is visible
    max_members = page.find_field('season_max_members')
    max_teams = page.find_field('season_max_teams')
    max_teams_size = page.find_field('season_max_team_size')

    # should be read only
    fill_in 'Max members', with: test_value
    fill_in 'Max teams', with: test_value
    fill_in 'Max team size', with: test_value
    message = "Readonly field should be blank"
    assert max_members.value.blank?, message
    assert max_teams.value.blank?, message
    assert max_teams_size.value.blank?, message

    # remove readonly and try now?
    uncheck 'season_max_membersno-max'
    uncheck 'season_max_teamsno-max'
    uncheck 'season_max_team_sizeno-max'
    fill_in 'Max members', with: test_value
    fill_in 'Max teams', with: test_value
    fill_in 'Max team size', with: test_value
    message = "Should be the filled in value now"
    assert max_members.value == test_value, message
    assert max_teams.value == test_value, message
    assert max_teams_size.value == test_value, message

    # nulls out value when checked
    check 'season_max_membersno-max'
    check 'season_max_teamsno-max'
    check 'season_max_team_sizeno-max'
    message = "Should be forced blank"
    assert max_members.value.blank?, message
    assert max_teams.value.blank?, message
    assert max_teams_size.value.blank?, message

    Capybara.use_default_driver 
  end


end
