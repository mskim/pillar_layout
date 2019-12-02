class SectionHeadingsController < ApplicationController
  before_action :set_section_heading, only: [:show, :edit, :update, :destroy]

  # GET /section_headings
  # GET /section_headings.json
  def index
    @section_headings = SectionHeading.all
  end

  # GET /section_headings/1
  # GET /section_headings/1.json
  def show
  end

  # GET /section_headings/new
  def new
    @section_heading = SectionHeading.new
  end

  # GET /section_headings/1/edit
  def edit
  end

  # POST /section_headings
  # POST /section_headings.json
  def create
    @section_heading = SectionHeading.new(section_heading_params)

    respond_to do |format|
      if @section_heading.save
        format.html { redirect_to @section_heading, notice: 'Section heading was successfully created.' }
        format.json { render :show, status: :created, location: @section_heading }
      else
        format.html { render :new }
        format.json { render json: @section_heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_headings/1
  # PATCH/PUT /section_headings/1.json
  def update
    respond_to do |format|
      if @section_heading.update(section_heading_params)
        format.html { redirect_to @section_heading, notice: 'Section heading was successfully updated.' }
        format.json { render :show, status: :ok, location: @section_heading }
      else
        format.html { render :edit }
        format.json { render json: @section_heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_headings/1
  # DELETE /section_headings/1.json
  def destroy
    @section_heading.destroy
    respond_to do |format|
      format.html { redirect_to section_headings_url, notice: 'Section heading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_heading
      @section_heading = SectionHeading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_heading_params
      params.require(:section_heading).permit(:page_number, :section_name, :date, :layout, :publication_id)
    end
end
