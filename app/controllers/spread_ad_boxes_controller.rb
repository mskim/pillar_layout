class SpreadAdBoxesController < ApplicationController
  before_action :set_spread_ad_box, only: [:show, :edit, :update, :destroy]

  # GET /spread_ad_boxes
  # GET /spread_ad_boxes.json
  def index
    @spread_ad_boxes = SpreadAdBox.all
  end

  # GET /spread_ad_boxes/1
  # GET /spread_ad_boxes/1.json
  def show
  end

  # GET /spread_ad_boxes/new
  def new
    @spread_ad_box = SpreadAdBox.new
  end

  # GET /spread_ad_boxes/1/edit
  def edit
  end

  # POST /spread_ad_boxes
  # POST /spread_ad_boxes.json
  def create
    @spread_ad_box = SpreadAdBox.new(spread_ad_box_params)

    respond_to do |format|
      if @spread_ad_box.save
        format.html { redirect_to @spread_ad_box, notice: 'Spread ad box was successfully created.' }
        format.json { render :show, status: :created, location: @spread_ad_box }
      else
        format.html { render :new }
        format.json { render json: @spread_ad_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spread_ad_boxes/1
  # PATCH/PUT /spread_ad_boxes/1.json
  def update
    respond_to do |format|
      if @spread_ad_box.update(spread_ad_box_params)
        format.html { redirect_to @spread_ad_box, notice: 'Spread ad box was successfully updated.' }
        format.json { render :show, status: :ok, location: @spread_ad_box }
      else
        format.html { render :edit }
        format.json { render json: @spread_ad_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spread_ad_boxes/1
  # DELETE /spread_ad_boxes/1.json
  def destroy
    @spread_ad_box.destroy
    respond_to do |format|
      format.html { redirect_to spread_ad_boxes_url, notice: 'Spread ad box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spread_ad_box
      @spread_ad_box = SpreadAdBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spread_ad_box_params
      params.require(:spread_ad_box).permit(:ad_type, :advertiser, :row, :width, :height, :spread_id)
    end
end
