class AnnotationUnderlinesController < ApplicationController
  before_action :set_annotation_underline, only: [:show, :edit, :update, :destroy]

  # GET /annotation_underlines
  # GET /annotation_underlines.json
  def index
    @annotation_underlines = AnnotationUnderline.all
  end

  # GET /annotation_underlines/1
  # GET /annotation_underlines/1.json
  def show
  end

  # GET /annotation_underlines/new
  def new
    @annotation_underline = AnnotationUnderline.new
  end

  # GET /annotation_underlines/1/edit
  def edit
  end

  # POST /annotation_underlines
  # POST /annotation_underlines.json
  def create
    @annotation_underline = AnnotationUnderline.new(annotation_underline_params)

    respond_to do |format|
      if @annotation_underline.save
        format.html { redirect_to @annotation_underline, notice: 'Annotation underline was successfully created.' }
        format.json { render :show, status: :created, location: @annotation_underline }
      else
        format.html { render :new }
        format.json { render json: @annotation_underline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotation_underlines/1
  # PATCH/PUT /annotation_underlines/1.json
  def update
    respond_to do |format|
      if @annotation_underline.update(annotation_underline_params)
        format.html { redirect_to @annotation_underline, notice: 'Annotation underline was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation_underline }
      else
        format.html { render :edit }
        format.json { render json: @annotation_underline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotation_underlines/1
  # DELETE /annotation_underlines/1.json
  def destroy
    @annotation_underline.destroy
    respond_to do |format|
      format.html { redirect_to annotation_underlines_url, notice: 'Annotation underline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation_underline
      @annotation_underline = AnnotationUnderline.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_underline_params
      params.require(:annotation_underline).permit(:x, :y, :width, :height, :color, :annotation_id, :user_id)
    end
end
