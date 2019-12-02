class AdBoxTemplatesController < ApplicationController
  before_action :set_ad_box_template, only: [:show, :edit, :update, :destroy]

  # GET /ad_box_templates
  # GET /ad_box_templates.json
  def index
    @ad_box_templates = AdBoxTemplate.all
  end

  # GET /ad_box_templates/1
  # GET /ad_box_templates/1.json
  def show
  end

  # GET /ad_box_templates/new
  def new
    @ad_box_template = AdBoxTemplate.new
  end

  # GET /ad_box_templates/1/edit
  def edit
  end

  # POST /ad_box_templates
  # POST /ad_box_templates.json
  def create
    @ad_box_template = AdBoxTemplate.new(ad_box_template_params)

    respond_to do |format|
      if @ad_box_template.save
        format.html { redirect_to @ad_box_template, notice: 'Ad box template was successfully created.' }
        format.json { render :show, status: :created, location: @ad_box_template }
      else
        format.html { render :new }
        format.json { render json: @ad_box_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_box_templates/1
  # PATCH/PUT /ad_box_templates/1.json
  def update
    respond_to do |format|
      if @ad_box_template.update(ad_box_template_params)
        format.html { redirect_to @ad_box_template, notice: 'Ad box template was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_box_template }
      else
        format.html { render :edit }
        format.json { render json: @ad_box_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_box_templates/1
  # DELETE /ad_box_templates/1.json
  def destroy
    @ad_box_template.destroy
    respond_to do |format|
      format.html { redirect_to ad_box_templates_url, notice: 'Ad box template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_box_template
      @ad_box_template = AdBoxTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_box_template_params
      params.require(:ad_box_template).permit(:column, :row, :ad_type, :section_id)
    end
end
