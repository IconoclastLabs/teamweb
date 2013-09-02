class SeasonsController < ApplicationController
  before_action :set_parents
  before_action :set_season, only: [:show, :edit, :update, :destroy]
  
  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.order(:name).page params[:page]
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
  end

  # GET /seasons/new
  def new
    @season = @organization.seasons.build(params[:season])
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons
  # POST /seasons.json
  def create
    @season = @organization.seasons.build(season_params)

    respond_to do |format|
      if @season.save
        format.html { redirect_to [@organization, @season], notice: 'Season was successfully created.' }
        format.json { render action: 'show', status: :created, location: @season }
      else
        format.html { render action: 'new' }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasons/1
  # PATCH/PUT /seasons/1.json
  def update
    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to [@organization, @season], notice: 'Season was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    @season.destroy
    respond_to do |format|
      format.html { redirect_to organization_seasons_url }
      format.json { head :no_content }
    end
  end

  private
    def set_season
      @season = Season.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_parents
      @organization = Organization.friendly.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_params
      params.require(:season).permit(:name, :start, :end, :members_allowed, :max_members, :teams_allowed, :max_teams, :max_team_size)
    end
end
