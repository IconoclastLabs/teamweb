class EventsController < ApplicationController
  before_action :set_parents, only: [:show, :edit, :update, :destroy, :add_user]

  def add_user
    @event = Event.find(params[:id])
    # Only add user if they won't blow out team size.
    if @event.add_event_member(current_user) 
      message = {notice: 'You have been added to the event!'}
    else
      message = {alert: 'This event is full and cannot accept any new members.'}
    end
    redirect_to [@organization, @event], message 
  end

  #def list
  #  @events = Event.all

  #  respond_to do |format|
  #    format.html #{ render "events/index" }
  #    format.json { render json: @events }
  #  end
  #end
  def list
    @events = Event.order(:name).page params[:page]
  end

  #def index
  #  @events = @organization.events

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @events }
  #  end
  #end
  def index
    @season = Season.find(params[:season_id])
    @events = @season.events.order(:name).page params[:page]
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @season.events.find(params[:id])
    @maps_json = @event.to_gmaps4rails do |event, marker|
      marker.title event.name 
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @season = Season.find(params[:season_id])
    @organization = @season.organization
    @event = @season.events.build(params[:event])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @season.events.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @season = Season.find(params[:season_id])
    @organization = @season.organization
    @event = @season.events.new(event_params)

    Event.transaction do
      respond_to do |format|
        if @event.save
          # Automatically add creator as admin
          @event.members.add_member(current_user, admin_flag: true)
          format.html { redirect_to [@season.organization, @season, @event], notice: 'Event was successfully created.' }
          format.json { render json: [@season.organization, @season, @event], status: :created, location: @event }
        else
          format.html { render action: "new" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end 
    end # end transaction
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @season = Season.find(params[:season_id])
    @organization = @season.organization    
    @event = @season.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to [@organization, @season, @event], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to organization_season_events_url }
      format.json { head :no_content }
    end
  end

  private
    def set_parents
      @organization = Organization.friendly.find(params[:organization_id])
      @season = Season.find(params[:season_id])
    end

    def event_params
      params.require(:event).permit(:about, :end, :location, :name, :start, :max_members, :members_allowed, :teams_allowed, :max_teams, :max_team_size)
    end
end
