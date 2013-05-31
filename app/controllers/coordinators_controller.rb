class CoordinatorsController < ApplicationController
  # GET /coordinators
  # GET /coordinators.json
  def index
    @coordinators = Coordinator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coordinators }
    end
  end

  # GET /coordinators/1
  # GET /coordinators/1.json
  def show
    @coordinator = Coordinator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coordinator }
    end
  end

  # GET /coordinators/new
  # GET /coordinators/new.json
  def new
    @coordinator = Coordinator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coordinator }
    end
  end

  # GET /coordinators/1/edit
  def edit
    @coordinator = Coordinator.find(params[:id])
  end

  # POST /coordinators
  # POST /coordinators.json
  def create
    @coordinator = Coordinator.new(params[:coordinator])

    respond_to do |format|
      if @coordinator.save
        format.html { redirect_to @coordinator, notice: 'Coordinator was successfully created.' }
        format.json { render json: @coordinator, status: :created, location: @coordinator }
      else
        format.html { render action: "new" }
        format.json { render json: @coordinator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coordinators/1
  # PUT /coordinators/1.json
  def update
    @coordinator = Coordinator.find(params[:id])

    respond_to do |format|
      if @coordinator.update_attributes(params[:coordinator])
        format.html { redirect_to @coordinator, notice: 'Coordinator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coordinator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coordinators/1
  # DELETE /coordinators/1.json
  def destroy
    @coordinator = Coordinator.find(params[:id])
    @coordinator.destroy

    respond_to do |format|
      format.html { redirect_to coordinators_url }
      format.json { head :no_content }
    end
  end
end
