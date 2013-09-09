# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model

  delegate :name, :location, :about, :start, :end, to: :event
  delegate :season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, to: :season
  delegate :org_name, :org_about, :org_location, :contact, to: :organization

  def organization
    @organization ||= Organization.new
  end

  def season
    @season ||= organization.seasons.build
  end

  def event
    @event ||= season.events.build
  end

  # so that URLs build correctly
  def self.model_name
    ActiveModel::Name.new(self, nil, "Event")
  end

  def submit(params)
    params.permit! # no need for strong params, since we're handling what is accessed here.
    organization.attributes = params.slice(:org_name, :org_about, :org_location, :contact)
    season.attributes = params.slice(:season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size)
    event.attributes = params.slice(:name, :location, :about, :start, :end)

    # TODO Move these 3 valid checks to EventForm valid check
    if organization.valid? && season.valid? && event.valid?
      organization.save!
      season.save!
      event.save!
      true
    else
      # TODO handle errors correctly
      self.errors[:base] << organization.errors.messages
      self.errors[:base] << season.errors.messages
      self.errors[:base] << event.errors.messages
      false
    end
  end


end