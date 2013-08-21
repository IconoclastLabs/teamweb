require 'test_helper'
require 'capybara/rails'
require 'forgery'

class OrganizationFlowsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
  end

  test "certain index buttons require login" do
    visit organizations_path
    assert page.has_no_link?("New Organization"), "Shouldn't have a new button"
    assert page.has_no_link?("Edit"), "Shouldn't have a edit button"
    assert page.has_no_link?("Delete"), "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    capybara_sign_in(@user)
    visit organizations_path
    assert page.has_link?("New Organization"), "Should have a new button"
    assert page.has_link?("Edit"), "Should have a edit button"
    assert page.has_link?("Delete"), "Should have a delete button"
  end  
end