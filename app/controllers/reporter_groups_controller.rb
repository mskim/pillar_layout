class ReporterGroupsController < ApplicationController
  before_action :set_reporter_group, only: [:show, :edit, :update, :destroy]

  # GET /reporter_groups
  # GET /reporter_groups.json
  def index
    @reporter_groups = ReporterGroup.all
  end

  # GET /reporter_groups/1
  # GET /reporter_groups/1.json
  def show
  end

  # GET /reporter_groups/new
  def new
    @reporter_group = ReporterGroup.new
  end

  # GET /reporter_groups/1/edit
  def edit
  end

  # POST /reporter_groups
  # POST /reporter_groups.json
  def create
    @reporter_group = ReporterGroup.new(reporter_group_params)

    respond_to do |format|
      if @reporter_group.save
        format.html { redirect_to @reporter_group, notice: 'Reporter group was successfully created.' }
        format.json { render :show, status: :created, location: @reporter_group }
      else
        format.html { render :new }
        format.json { render json: @reporter_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reporter_groups/1
  # PATCH/PUT /reporter_groups/1.json
  def update
    respond_to do |format|
      if @reporter_group.update(reporter_group_params)
        format.html { redirect_to @reporter_group, notice: 'Reporter group was successfully updated.' }
        format.json { render :show, status: :ok, location: @reporter_group }
      else
        format.html { render :edit }
        format.json { render json: @reporter_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporter_groups/1
  # DELETE /reporter_groups/1.json
  def destroy
    @reporter_group.destroy
    respond_to do |format|
      format.html { redirect_to reporter_groups_url, notice: 'Reporter group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reporter_group
      @reporter_group = ReporterGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reporter_group_params
      params.require(:reporter_group).permit(:section, :leader, :page_range)
    end
end
