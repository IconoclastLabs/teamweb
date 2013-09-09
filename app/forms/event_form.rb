# TODO: Strongly consider https://github.com/apotonick/reform
class EventForm
  include ActiveModel::Model

  delegate :name, :location, :about, :start, :end, to: :event
  #delegate :name, :max_team_size, :max_teams, :max_members, to: :season

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
    event.attributes = params.slice(:name, :location, :about, :start, :end)
    if event.valid?
      event.save!
      true
    else
      false
    end
  end


end