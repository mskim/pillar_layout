# frozen_string_literal: true

class GroupImagesController < ApplicationController
  before_action :set_group_image, only: %i[show edit update destroy]

  # GET /group_images
  # GET /group_images.json
  def index
    @group_images = GroupImage.all
  end

  # GET /group_images/1
  # GET /group_images/1.json
  def show
    @member_image = MemberImage.new
    @member_images = MemberImage.all
  end

  # GET /group_images/new
  def new
    @group_image = GroupImage.new
  end

  # GET /group_images/1/edit
  def edit; end

  # POST /group_images
  # POST /group_images.json
  def create
    @group_image = GroupImage.new(group_image_params)

    respond_to do |format|
      if @group_image.save
        format.html { redirect_to @group_image.working_article, notice: 'Group image was successfully created.' }
        format.json { render :show, status: :created, location: @group_image }
      else
        format.html { render :new }
        format.json { render json: @group_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_images/1
  # PATCH/PUT /group_images/1.json
  def update
    respond_to do |format|
      if @group_image.update(group_image_params)
        format.html { redirect_to @group_image.working_article, notice: 'Group image was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_image }
      else
        format.html { render :edit }
        format.json { render json: @group_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_images/1
  # DELETE /group_images/1.json
  def destroy
    @group_image.destroy
    respond_to do |format|
      format.html { redirect_to @group_image.working_article, notice: 'Group image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def wa_redirect
    @group_image
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_image
    @group_image = GroupImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_image_params
    params.require(:group_image).permit(:title, :caption, :source, :direction, :position, :working_article_id)
  end
end
