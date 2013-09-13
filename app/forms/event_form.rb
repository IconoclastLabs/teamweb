# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model
  # Objects
  attr_accessor :organization, :season, :event
  # Properties that don't come from objects
  attr_accessor :owner, :season_allowed

  validate :all_parts_valid
  delegate :name, :location, :about, :start, :end, to: :event
  delegate :season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, to: :season
  delegate :org_name, :org_about, :org_location, :contact, to: :organization

  def initialize
    super

    @organization ||= Organization.new
    @season = @organization.seasons.build
    @event = @season.events.build
    # TODO: don't hardcode this
    @owner = "Me"
    @season.members_allowed = false
    @season.teams_allowed = false
  end

  # so that URLs build correctly
  def self.model_name
    ActiveModel::Name.new(self, nil, "Event")
  end

  def submit(params)
    params.permit! # no need for strong params, since we're handling what is accessed here.
    @organization.attributes = params.slice(:org_name, :org_about, :org_location, :contact)
    @season.attributes = params.slice(:season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size)
    @event.attributes = params.slice(:name, :location, :about, :start, :end)

    # TODO: yeah.. just fix this stuff
    if params[:season_allowed] == "0"
      @season.season_name = @event.name
    end

    # TODO Enforce this is unique name
    if params[:owner] == 'Me'
      @organization.org_name = @event.name
      @organization.org_about = @event.about
      @organization.contact = @event.location
    end

    if valid?
      Organization.transaction do
        @organization.save!
        @season.save!
        @event.save!
      end
    else
      false
    end
  end

  private
    def all_parts_valid
      check_model @organization
      check_model @season
      check_model @event
    end

    def check_model model
      model.valid?
      model.errors.full_messages.each do |error|
        self.errors.add(:event_form, error)
      end
    end

end