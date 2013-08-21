class TeamsController < ApplicationController
  before_action :set_parents
  before_action :set_team, only: [:show, :edit, :update, :destroy, :add_user]

  def add_user
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
    @teams = @season.teams.order(:name).page params[:page]
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = @season.teams.build(params[:team])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = @season.teams.new(team_params)

    Team.transaction do
      respond_to do |format|
        if @team.save
          # Automatically add creator as admin
          @team.members.add_member(current_user, admin_flag: true)
          #format.html { redirect_to @team, notice: 'Team was successfully created.' }
          #format.json { render json: @team, status: :created, location: @team }
          format.html { redirect_to [@organization, @season, @team], notice: 'Team was successfully created.' }
          format.json { render json: [@organization, @season, @team], status: :created, location: @team }
        else
          format.html { render action: "new" }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end # end transaction
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update_attributes(team_params)
        format.html { redirect_to [@organization, @season, @team], notice: 'Team was successfully updated.' }
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
    @team.destroy

    respond_to do |format|
      format.html { redirect_to organization_season_teams_url(@team.season.organization, @team.season) }
      format.json { head :no_content }
    end
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

    def set_parents
      @season = Season.find(params[:season_id])
      @organization = @season.organization
    end

    def team_params
      params.require(:team).permit(:name, :max_members)
    end
end
