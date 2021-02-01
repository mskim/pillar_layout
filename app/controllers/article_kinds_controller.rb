class ArticleKindsController < ApplicationController
  before_action :set_article_kind, only: %i[ show edit update destroy ]

  # GET /article_kinds or /article_kinds.json
  def index
    @article_kinds = ArticleKind.all
  end

  # GET /article_kinds/1 or /article_kinds/1.json
  def show
  end

  # GET /article_kinds/new
  def new
    @article_kind = ArticleKind.new
  end

  # GET /article_kinds/1/edit
  def edit
  end

  # POST /article_kinds or /article_kinds.json
  def create
    @article_kind = ArticleKind.new(article_kind_params)

    respond_to do |format|
      if @article_kind.save
        format.html { redirect_to @article_kind, notice: "Article kind was successfully created." }
        format.json { render :show, status: :created, location: @article_kind }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_kinds/1 or /article_kinds/1.json
  def update
    respond_to do |format|
      if @article_kind.update(article_kind_params)
        format.html { redirect_to @article_kind, notice: "Article kind was successfully updated." }
        format.json { render :show, status: :ok, location: @article_kind }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_kinds/1 or /article_kinds/1.json
  def destroy
    @article_kind.destroy
    respond_to do |format|
      format.html { redirect_to article_kinds_url, notice: "Article kind was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_kind
      @article_kind = ArticleKind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_kind_params
      params.require(:article_kind).permit(:publication_id, :name, :line_draw_sides, :input_fields, :bottoms_space_in_lines, :layout_erb)
    end
end
