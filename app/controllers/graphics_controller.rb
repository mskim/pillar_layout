# frozen_string_literal: true

class GraphicsController < ApplicationController
  before_action :set_graphic, only: %i[show edit update destroy]

  # GET /graphics
  # GET /graphics.json
  def index
    @graphics = Graphic.all
  end

  # GET /graphics/1
  # GET /graphics/1.json
  def show; end

  # GET /graphics/new
  def new
    @graphic = Graphic.new
  end

  # GET /graphics/1/edit
  def edit; end

  # POST /graphics
  # POST /graphics.json
  def create
    @graphic = Graphic.new(graphic_params)

    respond_to do |format|
      if @graphic.save
        format.html { redirect_to @graphic, notice: 'Graphic was successfully created.' }
        format.json { render :show, status: :created, location: @graphic }
      else
        format.html { render :new }
        format.json { render json: @graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphics/1
  # PATCH/PUT /graphics/1.json
  def update
    respond_to do |format|
      if @graphic.update(graphic_params)
        @graphic.working_article.generate_pdf_with_time_stamp
        @graphic.working_article.page.generate_pdf_with_time_stamp

        format.html { redirect_to @graphic.working_article, notice: 'Graphic was successfully updated.' }
        format.json { render :show, status: :ok, location: @graphic }
      else
        format.html { render :edit }
        format.json { render json: @graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphics/1
  # DELETE /graphics/1.json
  def destroy
    working_article = @graphic.working_article
    @graphic.destroy
    working_article.generate_pdf_with_time_stamp
    working_article.page.generate_pdf_with_time_stamp
    respond_to do |format|
      format.html { redirect_to working_article_path(working_article), notice: 'Graphic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_graphic
    @graphic = Graphic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def graphic_params
    params.require(:graphic).permit(:grid_x, :grid_y, :column, :row, :extra_height_in_lines, :graphic, :caption, :source, :position, :page_number, :story_number, :working_article_id, :issue_id, :fit_type, :x_grid, :draw_frame, :title, :description, :image_path, :storage_graphic)
  end
end
