class TeamsController < ApplicationController
  before_filter :get_objects

  def get_objects
    @event = Event.find(params[:event_id])
    @organization = @event.organization
  end

  def add_user
    @team = Team.find(params[:id])
    # Only add user if they won't blow out team size.
    if @team.add_team_member(current_user) 
      message = {notice: 'You have been added to the team!'}
    else
      message = {alert: 'This team is full and cannot accept any new members.'}
    end
    redirect_to [@organization, @event, @team], message 
  end

  #def index
  #  @teams = @event.teams

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @teams }
  #  end
  #end
  def index
    @teams = @event.teams.order(:name).page params[:page]
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  #  @team = Team.find(params[:id])
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = @event.teams.build(params[:team])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    #@team = Team.find(params[:id])
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = @event.teams.new(team_params)

    respond_to do |format|
      if @team.save
        # Automatically add creator as admin
        @team.members.add_member(current_user, admin_flag: true)
        #format.html { redirect_to @team, notice: 'Team was successfully created.' }
        #format.json { render json: @team, status: :created, location: @team }
        format.html { redirect_to [@organization, @event, @team], notice: 'Team was successfully created.' }
        format.json { render json: [@organization, @event, @team], status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    #@team = Team.find(params[:id])
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(team_params)
        format.html { redirect_to [@organization, @event, @team], notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_member
    #@team = Team.find(params[:id])
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(team_params)
        @team.members.add_member(current_user, admin_flag: false)
        format.html { redirect_to [@organization, @event, @team], notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to organization_event_teams_url(@team.event.organization, @team.event) }
      format.json { head :no_content }
    end
  end

  def team_params
    params.require(:team).permit(:name, :max_members)
  end
end
