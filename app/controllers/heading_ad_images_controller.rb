class HeadingAdImagesController < ApplicationController
  before_action :set_heading_ad_image, only: [:show, :edit, :update, :destroy, :today]

  # GET /heading_ad_images
  # GET /heading_ad_images.json
  def index
    @heading_ad_images = HeadingAdImage.all
    
  end

  # GET /heading_ad_images/1
  # GET /heading_ad_images/1.json
  def show
    
  end

  # GET /heading_ad_images/new
  def new
    @heading_ad_image = HeadingAdImage.new
    
  end

  # GET /heading_ad_images/1/edit
  def edit
    
  end

  # POST /heading_ad_images
  # POST /heading_ad_images.json
  def create
    @heading_ad_image = HeadingAdImage.new(heading_ad_image_params)
    @heading_ad_image.update_page_heading
    respond_to do |format|
      if @heading_ad_image.save
        @heading_ad_image.update_page_heading
        format.html { redirect_to first_group_issue_path(Issue.last), notice: '당일 돌출 광고가 적용되었습니다.' }
        format.json { render :show, status: :created, location: @heading_ad_image }
      else
        format.html { render :new }
        format.json { render json: @heading_ad_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heading_ad_images/1
  # PATCH/PUT /heading_ad_images/1.json
  def update
    respond_to do |format|
      if @heading_ad_image.update(heading_ad_image_params)
        @heading_ad_image.update_page_heading
        format.html { redirect_to @heading_ad_image, notice: '돌출 광고가 수정되었습니다.' }
        format.json { render :show, status: :ok, location: @heading_ad_image }
      else
        format.html { render :edit }
        format.json { render json: @heading_ad_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heading_ad_images/1
  # DELETE /heading_ad_images/1.json
  def destroy
    @heading_ad_image.destroy
    respond_to do |format|
      format.html { redirect_to heading_ad_images_url, notice: '돌출 광고가 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  def today
    @heading_ad_image.place_ad_for_today
    redirect_to @heading_ad_image, notice: "오늘 돌출 광고에 설정되었슴니다"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heading_ad_image
      @heading_ad_image = HeadingAdImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heading_ad_image_params
      params.require(:heading_ad_image).permit(:heading_ad_image, :x, :y, :width, :height, :x_in_unit, :y_in_unit, :width_in_unit, :height_in_unit, :page_heading_id, :advertiser)
    end
end
