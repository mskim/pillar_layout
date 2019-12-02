class AdPlansController < ApplicationController
  before_action :set_ad_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /ad_plans
  # GET /ad_plans.json
  def index
    @ad_plans = AdPlan.all
    
  end

  # GET /ad_plans/1
  # GET /ad_plans/1.json
  def show
  end

  # GET /ad_plans/new
  def new
    @ad_plan = AdPlan.new
  end

  # GET /ad_plans/1/edit
  def edit
  end

  # POST /ad_plans
  # POST /ad_plans.json
  def create
    @ad_plan = AdPlan.new(ad_plan_params)

    respond_to do |format|
      if @ad_plan.save
        format.html { redirect_to @ad_plan, notice: 'Ad plan was successfully created.' }
        format.json { render :show, status: :created, location: @ad_plan }
      else
        format.html { render :new }
        format.json { render json: @ad_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_plans/1
  # PATCH/PUT /ad_plans/1.json
  def update
    respond_to do |format|
      if @ad_plan.update(ad_plan_params)
        format.html { redirect_to @ad_plan, notice: 'Ad plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_plan }
      else
        format.html { render :edit }
        format.json { render json: @ad_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_plans/1
  # DELETE /ad_plans/1.json
  def destroy
    @ad_plan.destroy
    respond_to do |format|
      format.html { redirect_to ad_plans_url, notice: 'Ad plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_plan
      @ad_plan = AdPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_plan_params
      params.require(:ad_plan).permit(:date, :page_number, :ad_type, :advertiser, :color_page, :comment)
    end
end
