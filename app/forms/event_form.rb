# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model

  delegate :name, :location, :about, :start, :end, to: :event
  delegate :season_name, :season_start, :season_end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size, to: :season
  delegate :org_name, :org_about, :location, :contact, to: :organization

  def event
    @event ||= Event.new
  end

  # so that URLs build correctly
  def self.model_name
    ActiveModel::Name.new(self, nil, "Event")
  end


  # def season
  #   @season = Season.new
  # end

  def submit(params)
    #event.attributes = params.require(:event).permit(:name, :location, :about, :start, :end)
    params.permit!
    event.attributes = params.slice(:name, :location, :about, :start, :end)
    if event.valid?
      event.save!
      true
    else
      false
    end
  end


end