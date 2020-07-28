# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy crop clear_crop]
  before_action :authenticate_user!

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  def current
    @current_images = Image.current_images
  end

  def place_all
    Image.place_all_images
    redirect_to images_issue_path(Issue.last.id), notice: 'All images were successfully placed.'
  end

  # GET /images/1
  # GET /images/1.json
  def show; end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit; end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      current_order = @image.order
      if @image.update(image_params)
        # if image_params[:crop_x]
        if current_order != @image.order
          @image.change_sybling_orders
        end
        if @image.working_article_id
          @image.working_article.generate_pdf_with_time_stamp
          @image.working_article.page.generate_pdf_with_time_stamp
        end

        format.html do
          if @image.working_article_id
            redirect_to working_article_path(@image.working_article_id), notice: '이미지 정보가 수정되었습니다.'
          else
            redirect_to images_issue_path(@image.issue_id), notice: '이미지 정보가 수정되었습니다.'
          end
        end
        format.json do
          render :show, status: :ok, location: @image
        end
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    working_article = @image.working_article
    issue_id = @image.issue_id
    @image.destroy
    working_article.generate_pdf_with_time_stamp
    working_article.page.generate_pdf_with_time_stamp
    respond_to do |format|
      # format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.html { redirect_to working_article_path(working_article), notice: '사진이 성공적으로 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  def crop
    @grid_width = @image.working_article.grid_width
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:column, :row, :extra_height_in_lines, :image_path, :caption_title, :caption, :source, :position, :page_number, :story_number, :issue_id, :image, :working_article_id, :x_grid, :fit_type, :draw_frame, :image_kind, :not_related, :image_path, :zoom_level, :zoom_direction, :crop_x, :crop_y, :crop_w, :crop_h, :storage_image, :order)
  end
end
