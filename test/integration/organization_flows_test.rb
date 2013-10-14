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
    assert page.has_no_link?("Edit"), "Shouldn't have an edit button"
    assert page.has_no_link?("Delete"), "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    capybara_sign_in(@user)
    visit organizations_path
    assert page.has_link?("New Organization"), "Should have a new button"
    assert page.has_link?("Edit"), "Should have an edit button"
    assert page.has_link?("Delete"), "Should have a delete button"
  end  

  test "Automatically has wysihtml5 editor" do
    capybara_sign_in(@user)
    visit new_organization_path

    assert page.has_css?("textarea.wysihtml5"), "Page should have a wysihtml5 editor"
  end

  test "Changes event tables buttons to fit on smaller displays" do
    Capybara.current_driver = :poltergeist 
    capybara_sign_in(@user)    
    visit organizations_path

    assert page.has_link?("Edit"), "Should have an edit button"
    assert page.has_no_button?("Actions"), "Should NOT have actions button"

    capybara_resize SMALL_SCREENSIZE

    assert page.has_no_link?("Edit"), "Should NOT have an edit button after resize"
    assert page.has_button?("Actions"), "Should have actions button after resize"

    capybara_resize LARGE_SCREENSIZE

    Capybara.use_default_driver
  end
end