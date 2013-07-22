require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "scope admins" do 
     non_admin = Member.where(admin: false).first
     admin = Member.where(admin: true).first
     Member.admins.wont_include non_admin
     Member.admins.must_include admin
  end

  test "scope event_members" do
    event_with_team_members = events(:event_one)
    member_of_team = members(:member_one)
    Member.event_team_members(event_with_team_members).must_include member_of_team
  end
end
