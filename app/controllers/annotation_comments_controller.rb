class AnnotationCommentsController < ApplicationController
  before_action :set_annotation_comment, only: [:show, :edit, :update, :destroy, :toggle_selected, :move_draggable]

  # GET /annotation_comments
  # GET /annotation_comments.json
  def index
    @annotation_comments = AnnotationComment.all
  end

  # GET /annotation_comments/1
  # GET /annotation_comments/1.json
  def show
  end

  # GET /annotation_comments/new
  def new
    @annotation_comment = AnnotationComment.new
  end

  # GET /annotation_comments/1/edit
  def edit
  end

  # POST /annotation_comments
  # POST /annotation_comments.json
  def create
    @annotation_comment = AnnotationComment.new(annotation_comment_params)
    @annotation_comment.user_id = current_user.id

    respond_to do |format|
      if @annotation_comment.save
        format.html { redirect_to @annotation_comment, notice: 'Annotation comment was successfully created.' }
        format.json { render :show, status: :created, location: @annotation_comment }
      else
        format.html { render :new }
        format.json { render json: @annotation_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annotation_comments/1
  # PATCH/PUT /annotation_comments/1.json
  def update
    respond_to do |format|
      if @annotation_comment.update(annotation_comment_params)
        format.html { redirect_to @annotation_comment, notice: 'Annotation comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @annotation_comment }
      else
        format.html { render :edit }
        format.json { render json: @annotation_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotation_comments/1
  # DELETE /annotation_comments/1.json
  def destroy
    @annotation_comment.destroy
    respond_to do |format|
      format.html { redirect_to annotation_comments_url, notice: 'Annotation comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_selected
    @annotation_comment.toggle_selected
    redirect_to @annotation_comment.annotation.working_article
  end

  def move_draggable
    @annotation_comment.update(params.require(:annotation_comment).permit(:x, :y))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation_comment
      @annotation_comment = AnnotationComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_comment_params
      params.require(:annotation_comment).permit(:annotation_id, :user, :comment, :shape, :color, :x, :y, :width, :height)
    end
end
