class AdImagesController < ApplicationController
  before_action :set_ad_image, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /ad_images
  # GET /ad_images.json
  def index
    @ad_images = AdImage.all
  end

  # GET /ad_images/1
  # GET /ad_images/1.json
  def show
  end

  # GET /ad_images/new
  def new
    @ad_image = AdImage.new
  end

  # GET /ad_images/1/edit
  def edit
  end

  # POST /ad_images
  # POST /ad_images.json
  def create
    @ad_image = AdImage.new(ad_image_params)

    respond_to do |format|
      if @ad_image.save
        format.html { redirect_to @ad_image, notice: 'Placed ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad_image }
      else
        format.html { render :new }
        format.json { render json: @ad_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_images/1
  # PATCH/PUT /ad_images/1.json
  def update
    respond_to do |format|
      if @ad_image.update(ad_image_params)
        format.html do
          @ad_image.place_ad_image
          if @ad_image.ad_box_id
            redirect_to ad_box_path(@ad_image.ad_box_id), notice: 'Ad Image was successfully updated.'
          else
            redirect_to ad_images_issue_path(@ad_image.issue_id), notice: 'Ad Image was successfully updated.'
          end
        end
        format.json { render :show, status: :ok, location: @ad_image }
      else
        format.html { render :edit }
        format.json { render json: @ad_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_images/1
  # DELETE /ad_images/1.json
  def destroy
    @ad_image.destroy
    respond_to do |format|
      format.html { redirect_to ad_images_url, notice: 'Placed ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def place_all
    AdImage.place_all_ad_images
    redirect_to ad_images_issue_path(Issue.last.id), notice: 'All images were successfully placed.'

    # redirect_to ad_images_issue_path(Issue.last.id), notice: 'All ad_images were successfully placed.'
    # redirect_to current_images_path, notice: 'All images were successfully placed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_image
      @ad_image = AdImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_image_params
      params.require(:ad_image).permit(:column, :row, :page_number, :story_number, :issue_id, :image, :working_article_id, :ad_box)
    end
end
