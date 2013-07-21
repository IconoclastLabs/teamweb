class EventsController < ApplicationController
  before_filter :get_organization

  def get_organization
    if params[:organization_id]
      @organization = Organization.find(params[:organization_id])
    end
  end

  # GET /events
  # GET /events.json
  def list
    @events = Event.all

    respond_to do |format|
      format.html #{ render "events/index" }
      format.json { render json: @events }
    end
  end

  # GET /events
  # GET /events.json
  def index
    @events = @organization.events

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @organization.events.find(params[:id])
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
    @event = @organization.events.build(params[:event])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @organization.events.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = @organization.events.new(event_params)

    respond_to do |format|
      if @event.save
        # Automatically add creator as admin
        @event.members.create(user_id: current_user.id, admin: true)        
        format.html { redirect_to [@organization, @event], notice: 'Event was successfully created.' }
        format.json { render json: [@organization, @event], status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = @organization.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to [@organization, @event], notice: 'Event was successfully updated.' }
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
      format.html { redirect_to organization_events_url }
      format.json { head :no_content }
    end
  end


  def event_params
    params.require(:event).permit(:about, :end, :location, :name, :start)
  end
end
