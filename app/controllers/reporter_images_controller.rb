# frozen_string_literal: true

class ReporterImagesController < ApplicationController
  before_action :set_reporter_image, only: %i[show edit update destroy]

  # GET /reporter_images
  # GET /reporter_images.json
  def index
    @reporter_images = ReporterImage.all
  end

  # GET /reporter_images/1
  # GET /reporter_images/1.json
  def show; end

  # GET /reporter_images/new
  def new
    @reporter_image = ReporterImage.new
  end

  # GET /reporter_images/1/edit
  def edit; end

  # POST /reporter_images
  # POST /reporter_images.json
  def create
    @reporter_image = ReporterImage.new(reporter_image_params)
    @reporter_image.user = current_user

    respond_to do |format|
      if @reporter_image.save
        format.html { redirect_to @reporter_image, notice: 'Reporter image was successfully created.' }
        format.json { render :show, status: :created, location: @reporter_image }
      else
        format.html { render :new }
        format.json { render json: @reporter_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reporter_images/1
  # PATCH/PUT /reporter_images/1.json
  def update
    respond_to do |format|
      if @reporter_image.update(reporter_image_params)
        format.html { redirect_to @reporter_image, notice: 'Reporter image was successfully updated.' }
        format.json { render :show, status: :ok, location: @reporter_image }
      else
        format.html { render :edit }
        format.json { render json: @reporter_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporter_images/1
  # DELETE /reporter_images/1.json
  def destroy
    @reporter_image.destroy
    respond_to do |format|
      format.html { redirect_to reporter_images_url, notice: 'Reporter image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my
    @q = ReporterImage.ransack(params[:q])
    @reporter_images = @q.result(distinct: true)
    @reporter_images = @reporter_images.order(:id).page(params[:page]).reverse_order.per(30)

    # @reporter_images = current_user.reporter_images.order(id: 'DESC')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reporter_image
    @reporter_image = ReporterImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reporter_image_params
    params.require(:reporter_image).permit(:user_id, :title, :caption, :source, :reporter_image, :remote_reporter_image_url, :section_name, :used_in_layout)
  end
end
