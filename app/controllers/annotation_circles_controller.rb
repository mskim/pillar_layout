class AnnotationCirclesController < ApplicationController
  before_action :set_annotation_circle, only: [:show, :edit, :update, :destroy]

  # GET /annotation_circles
  # GET /annotation_circles.json
  def index
    @annotation_circles = AnnotationCircle.all
  end

  # GET /annotation_circles/1
  # GET /annotation_circles/1.json
  def show
  end

  # GET /annotation_circles/new
  def new
    @annotation_circle = AnnotationCircle.new
  end

  # GET /annotation_circles/1/edit
  def edit
  end

  # POST /annotation_circles
  # POST /annotation_circles.json
  def create
    @annotation_circle = AnnotationCircle.new(annotation_circle_params)

    respond_to do |format|
      if @annotation_circle.save
        format.html { redirect_to @annotation_circle, notice: 'Annotation circle was successfully created.' }
        format.json { render :show, status: :created, location: @annotation_circle }
      else
        format.html { render :new }
        format.json { render json: @annotation_circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotation_circles/1
  # PATCH/PUT /annotation_circles/1.json
  def update
    respond_to do |format|
      if @annotation_circle.update(annotation_circle_params)
        format.html { redirect_to @annotation_circle, notice: 'Annotation circle was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation_circle }
      else
        format.html { render :edit }
        format.json { render json: @annotation_circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotation_circles/1
  # DELETE /annotation_circles/1.json
  def destroy
    @annotation_circle.destroy
    respond_to do |format|
      format.html { redirect_to annotation_circles_url, notice: 'Annotation circle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation_circle
      @annotation_circle = AnnotationCircle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_circle_params
      params.require(:annotation_circle).permit(:x, :y, :width, :height, :color, :annotation_id, :user_id)
    end
end
