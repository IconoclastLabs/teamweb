class EventsController < ApplicationController
  before_filter :get_coordinator

  def get_coordinator
    @coordinator = Coordinator.find(params[:coordinator_id])
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @coordinator.events.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = @coordinator.events.build(event_params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @coordinator.events.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = @coordinator.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to [@coordinator, @event], notice: 'Event was successfully created.' }
        format.json { render json: [@coordinator, @event], status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = @coordinator.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to [@coordinator, @event], notice: 'Event was successfully updated.' }
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
      format.html { redirect_to coordinator_events_url }
      format.json { head :no_content }
    end
  end


  def event_params
    params.require(:event).permit(:about, :end, :location, :name, :start)
  end
end
