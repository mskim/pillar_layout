class HeadingBgImagesController < ApplicationController
  before_action :set_heading_bg_image, only: [:show, :edit, :update, :destroy]

  # GET /heading_bg_images
  # GET /heading_bg_images.json
  def index
    @heading_bg_images = HeadingBgImage.all
  end

  # GET /heading_bg_images/1
  # GET /heading_bg_images/1.json
  def show
  end

  # GET /heading_bg_images/new
  def new
    @heading_bg_image = HeadingBgImage.new
  end

  # GET /heading_bg_images/1/edit
  def edit
  end

  # POST /heading_bg_images
  # POST /heading_bg_images.json
  def create
    @heading_bg_image = HeadingBgImage.new(heading_bg_image_params)

    respond_to do |format|
      if @heading_bg_image.save
        format.html { redirect_to @heading_bg_image, notice: 'Heading bg image was successfully created.' }
        format.json { render :show, status: :created, location: @heading_bg_image }
      else
        format.html { render :new }
        format.json { render json: @heading_bg_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heading_bg_images/1
  # PATCH/PUT /heading_bg_images/1.json
  def update
    respond_to do |format|
      if @heading_bg_image.update(heading_bg_image_params)
        format.html { redirect_to @heading_bg_image, notice: 'Heading bg image was successfully updated.' }
        format.json { render :show, status: :ok, location: @heading_bg_image }
      else
        format.html { render :edit }
        format.json { render json: @heading_bg_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heading_bg_images/1
  # DELETE /heading_bg_images/1.json
  def destroy
    @heading_bg_image.destroy
    respond_to do |format|
      format.html { redirect_to heading_bg_images_url, notice: 'Heading bg image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heading_bg_image
      @heading_bg_image = HeadingBgImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heading_bg_image_params
      params.require(:heading_bg_image).permit(:heading_bg_image, :page_heading_id)
    end
end
