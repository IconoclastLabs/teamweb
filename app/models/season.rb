# == Schema Information
#
# Table name: seasons
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  name            :string(255)      not null
#  start           :date
#  end             :date
#  members_allowed :boolean          default(TRUE), not null
#  max_members     :integer
#  teams_allowed   :boolean          default(TRUE), not null
#  max_teams       :integer
#  max_team_size   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Season < ActiveRecord::Base
end
