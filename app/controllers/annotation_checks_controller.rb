class AnnotationChecksController < ApplicationController
  before_action :set_annotation_check, only: [:show, :edit, :update, :destroy]

  # GET /annotation_checks
  # GET /annotation_checks.json
  def index
    @annotation_checks = AnnotationCheck.all
  end

  # GET /annotation_checks/1
  # GET /annotation_checks/1.json
  def show
  end

  # GET /annotation_checks/new
  def new
    @annotation_check = AnnotationCheck.new
  end

  # GET /annotation_checks/1/edit
  def edit
  end

  # POST /annotation_checks
  # POST /annotation_checks.json
  def create
    @annotation_check = AnnotationCheck.new(annotation_check_params)

    respond_to do |format|
      if @annotation_check.save
        format.html { redirect_to @annotation_check, notice: 'Annotation check was successfully created.' }
        format.json { render :show, status: :created, location: @annotation_check }
      else
        format.html { render :new }
        format.json { render json: @annotation_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotation_checks/1
  # PATCH/PUT /annotation_checks/1.json
  def update
    respond_to do |format|
      if @annotation_check.update(annotation_check_params)
        format.html { redirect_to @annotation_check, notice: 'Annotation check was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation_check }
      else
        format.html { render :edit }
        format.json { render json: @annotation_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotation_checks/1
  # DELETE /annotation_checks/1.json
  def destroy
    @annotation_check.destroy
    respond_to do |format|
      format.html { redirect_to annotation_checks_url, notice: 'Annotation check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation_check
      @annotation_check = AnnotationCheck.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_check_params
      params.require(:annotation_check).permit(:x, :y, :width, :height, :color, :annotation_id, :user_id)
    end
end
