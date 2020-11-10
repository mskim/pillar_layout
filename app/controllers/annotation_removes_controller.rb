class AnnotationRemovesController < ApplicationController
  before_action :set_annotation_remove, only: [:show, :edit, :update, :destroy, :move_draggable, :delete_it]

  # GET /annotation_removes
  # GET /annotation_removes.json
  def index
    @annotation_removes = AnnotationRemove.all
  end

  # GET /annotation_removes/1
  # GET /annotation_removes/1.json
  def show
  end

  # GET /annotation_removes/new
  def new
    @annotation_remove = AnnotationRemove.new
  end

  # GET /annotation_removes/1/edit
  def edit
  end

  # POST /annotation_removes
  # POST /annotation_removes.json
  def create
    @annotation_remove = AnnotationRemove.new(annotation_remove_params)

    respond_to do |format|
      if @annotation_remove.save
        format.html { redirect_to @annotation_remove, notice: 'Annotation remove was successfully created.' }
        format.json { render :show, status: :created, location: @annotation_remove }
      else
        format.html { render :new }
        format.json { render json: @annotation_remove.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotation_removes/1
  # PATCH/PUT /annotation_removes/1.json
  def update
    respond_to do |format|
      if @annotation_remove.update(annotation_remove_params)
        format.html { redirect_to @annotation_remove, notice: 'Annotation remove was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation_remove }
      else
        format.html { render :edit }
        format.json { render json: @annotation_remove.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotation_removes/1
  # DELETE /annotation_removes/1.json
  def destroy
    @annotation_remove.destroy
    respond_to do |format|
      format.html { redirect_to annotation_removes_url, notice: 'Annotation remove was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move_draggable
    @annotation_remove.update(params.require(:annotation_remove).permit(:x, :y))
  end

  def delete_it
    @annotation_remove.destroy
    redirect_to @annotation_remove.annotation.working_article
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation_remove
      @annotation_remove = AnnotationRemove.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_remove_params
      params.require(:annotation_remove).permit(:x, :y, :width, :height, :color, :annotation_id, :user_id)
    end
end
