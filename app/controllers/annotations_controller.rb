class AnnotationsController < ApplicationController
  before_action :set_annotation, only: [:show, :edit, :update, :destroy, :add_comment, :add_circle, :add_check, :add_underline, :add_remove_marker]

  # GET /annotations
  # GET /annotations.json
  def index
    @annotations = Annotation.all
  end

  # GET /annotations/1
  # GET /annotations/1.json
  def show
  end

  # GET /annotations/new
  def new
    @annotation = Annotation.new
  end

  # GET /annotations/1/edit
  def edit
  end

  # POST /annotations
  # POST /annotations.json
  def create
    @annotation = Annotation.new(annotation_params)

    respond_to do |format|
      if @annotation.save
        format.html { redirect_to @annotation, notice: 'Annotation was successfully created.' }
        format.json { render :show, status: :created, location: @annotation }
      else
        format.html { render :new }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotations/1
  # PATCH/PUT /annotations/1.json
  def update
    respond_to do |format|
      if @annotation.update(annotation_params)
        format.html { redirect_to @annotation, notice: 'Annotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation }
      else
        format.html { render :edit }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotations/1
  # DELETE /annotations/1.json
  def destroy
    @annotation.destroy
    respond_to do |format|
      format.html { redirect_to annotations_url, notice: 'Annotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_comment
    @annotation.add_comment(current_user.id)
    redirect_to @annotation.working_article
  end

  def add_circle
    @annotation.add_circle(current_user.id)
    redirect_to @annotation.working_article
  end

  def add_check
    @annotation.add_check(current_user.id)
    redirect_to @annotation.working_article
  end

  def add_underline
    @annotation.add_underline(current_user.id)
    redirect_to @annotation.working_article
  end

  def add_remove_marker
    @annotation.add_remove_marker(current_user.id)
    redirect_to @annotation.working_article
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation
      @annotation = Annotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_params
      params.require(:annotation).permit(:working_article_id, :version)
    end
end
