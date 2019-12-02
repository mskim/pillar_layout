class LineFragmentsController < ApplicationController
  before_action :set_line_fragment, only: [:show, :edit, :update, :destroy]

  # GET /line_fragments
  # GET /line_fragments.json
  def index
    @line_fragments = LineFragment.all
  end

  # GET /line_fragments/1
  # GET /line_fragments/1.json
  def show
  end

  # GET /line_fragments/new
  def new
    @line_fragment = LineFragment.new
  end

  # GET /line_fragments/1/edit
  def edit
  end

  # POST /line_fragments
  # POST /line_fragments.json
  def create
    @line_fragment = LineFragment.new(line_fragment_params)

    respond_to do |format|
      if @line_fragment.save
        format.html { redirect_to @line_fragment, notice: 'Line fragment was successfully created.' }
        format.json { render :show, status: :created, location: @line_fragment }
      else
        format.html { render :new }
        format.json { render json: @line_fragment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_fragments/1
  # PATCH/PUT /line_fragments/1.json
  def update
    respond_to do |format|
      if @line_fragment.update(line_fragment_params)
        format.html { redirect_to @line_fragment, notice: 'Line fragment was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_fragment }
      else
        format.html { render :edit }
        format.json { render json: @line_fragment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_fragments/1
  # DELETE /line_fragments/1.json
  def destroy
    @line_fragment.destroy
    respond_to do |format|
      format.html { redirect_to line_fragments_url, notice: 'Line fragment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_fragment
      @line_fragment = LineFragment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_fragment_params
      params.require(:line_fragment).permit(:working_article_id, :paragraph_id, :order, :column, :line_type, :x, :y, :width, :height, :tokens, :text_area_x, :text_area_width)
    end
end
