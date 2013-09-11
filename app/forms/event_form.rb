# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model
  validate :all_parts_valid
  delegate :name, :location, :about, :start, :end, to: :event
  delegate :season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, to: :season
  delegate :org_name, :org_about, :org_location, :contact, to: :organization

  # TODO: move these attributes to attr_accessors with initialize method?
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

    if self.valid?
      Organization.transaction do
        organization.save!
        season.save!
        event.save!
      end
    else
      false
    end
  end

  private
    def all_parts_valid
      check_model organization
      check_model season
      check_model event
    end

    def check_model model
      model.valid?
      model.errors.full_messages.each do |error|
        self.errors.add(:event_form, error)
      end
    end

end