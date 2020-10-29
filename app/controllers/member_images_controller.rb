# frozen_string_literal: true

class MemberImagesController < ApplicationController
  before_action :set_member_image, only: %i[show edit update destroy]

  # GET /member_images
  # GET /member_images.json
  def index
    @member_images = MemberImage.all
  end

  # GET /member_images/1
  # GET /member_images/1.json
  def show; end

  # GET /member_images/new
  def new
    @member_image = MemberImage.new
  end

  # GET /member_images/1/edit
  def edit; end

  # POST /member_images
  # POST /member_images.json
  def create
    @member_image = MemberImage.new(member_image_params)
    @member_image.working_article_id = WorkingArticle.find(params[:working_article_id])

    respond_to do |format|
      if @member_image.save
        format.html { redirect_to @member_image.working_article, notice: 'Member image was successfully created.' }
        format.json { render :show, status: :created, location: @member_image }
      else
        format.html { render :new }
        format.json { render json: @member_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /member_images/1
  # PATCH/PUT /member_images/1.json
  def update
    respond_to do |format|
      if @member_image.update(member_image_params)
        format.html { redirect_to @member_image.working_article, notice: 'Member image was successfully updated.' }
        format.json { render :show, status: :ok, location: @member_image }
      else
        format.html { render :edit }
        format.json { render json: @member_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_images/1
  # DELETE /member_images/1.json
  def destroy
    @member_image.destroy
    respond_to do |format|
      format.html { redirect_to @member_image.working_article, notice: 'Member image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member_image
    @member_image = MemberImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_image_params
    params.require(:member_image).permit(:title, :caption, :source, :order, :working_article_id, :member_img)
  end
end
