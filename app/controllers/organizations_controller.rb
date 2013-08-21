class OrganizationsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]
  #def index
  #  @organizations = Organization.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @organizations }
  #  end
  #end
  def index
    @organizations = Organization.order(:name).page params[:page]
  end

  def show
    # TODO rethink this
    # @maps_json = @organization.seasons.first.events.to_gmaps4rails do |event, marker|
    #   marker.title event.name 
    # end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end


  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    Organization.transaction do
      respond_to do |format|
        if @organization.save
          # Automatically add creator as admin
          @organization.members.add_member(current_user, admin_flag: true)

          format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
          format.json { render json: @organization, status: :created, location: @organization }
        else
          format.html { render action: "new" }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end # end transaction
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update_attributes(organization_params)
        format.html { redirect_to organization_path(@organization), notice: 'Organization was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private

    def set_org
      @organization = Organization.friendly.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:about, :contact, :location, :name)
    end
end
