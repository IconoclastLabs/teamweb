# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model
  # Objects
  attr_accessor :organization, :season, :event

  validate :all_parts_valid
  delegate :name, :location, :about, :start, :end, to: :event
  delegate :season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, :self_organized, :seasons_allowed, to: :season
  delegate :org_name, :org_about, :org_location, :contact, to: :organization

  def initialize(params=ActionController::Parameters.new({season_allowed: 0, members_allowed: false, teams_allowed: false}))
    
    # params.permit! # no need for strong params, since we're handling what is accessed here.
    params.permit! 
    @organization ||= Organization.new(params.slice(:org_name, :org_about, :org_location, :contact))
    @season = @organization.seasons.build(params.slice(:season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, :self_organized, :seasons_allowed))
    @event = @season.events.build(params.slice(:name, :location, :about, :start, :end))

  end

  # so that URLs build correctly
  def self.model_name
    ActiveModel::Name.new(self, nil, "Event")
  end

  def save
    @season.season_name = @event.name unless @season.seasons_allowed

    # TODO Enforce this is unique name
    if @season.self_organized
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
      check_model @event
      check_model @season unless self.errors.present?
      check_model @organization unless self.errors.present?
    end

    def check_model model
      model.valid?
      model.errors.full_messages.each do |error|
        self.errors.add(:base, error)
      end
    end

end