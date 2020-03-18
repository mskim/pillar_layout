class ComboAdsController < ApplicationController
  before_action :set_combo_ad, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /combo_ads
  # GET /combo_ads.json
  def index
    @combo_ads = ComboAd.all

    respond_to do |format|
      format.html
      format.json { render :index}
      format.csv { send_data @combo_ads.to_csv }
    end
  end

  # GET /combo_ads/1
  # GET /combo_ads/1.json
  def show
  end

  # GET /combo_ads/new
  def new
    @combo_ad = ComboAd.new
  end

  # GET /combo_ads/1/edit
  def edit
  end

  # POST /combo_ads
  # POST /combo_ads.json
  def create
    @combo_ad = ComboAd.new(combo_ad_params)

    respond_to do |format|
      if @combo_ad.save
        format.html { redirect_to @combo_ad, notice: 'Combo ad was successfully created.' }
        format.json { render :show, status: :created, location: @combo_ad }
      else
        format.html { render :new }
        format.json { render json: @combo_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /combo_ads/1
  # PATCH/PUT /combo_ads/1.json
  def update
    respond_to do |format|
      if @combo_ad.update(combo_ad_params)
        format.html { redirect_to @combo_ad, notice: 'Combo ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @combo_ad }
      else
        format.html { render :edit }
        format.json { render json: @combo_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combo_ads/1
  # DELETE /combo_ads/1.json
  def destroy
    @combo_ad.destroy
    respond_to do |format|
      format.html { redirect_to combo_ads_url, notice: 'Combo ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_combo_ad
      @combo_ad = ComboAd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def combo_ad_params
      params.require(:combo_ad).permit(:base_ad, :column, :row, :layout, :profile)
    end
end
