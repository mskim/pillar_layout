class StrokeStylesController < ApplicationController
  before_action :set_stroke_style, only: [:show, :edit, :update, :destroy, :save_current, :download_pdf]

  # GET /stroke_styles
  # GET /stroke_styles.json
  def index
    @stroke_styles = StrokeStyle.all
  end

  # GET /stroke_styles/1
  # GET /stroke_styles/1.json
  def show
  end

  # GET /stroke_styles/new
  def new
    @stroke_style = StrokeStyle.new
  end

  # GET /stroke_styles/1/edit
  def edit
  end

  # POST /stroke_styles
  # POST /stroke_styles.json
  def create
    @stroke_style = StrokeStyle.new(stroke_style_params)

    respond_to do |format|
      if @stroke_style.save
        format.html { redirect_to @stroke_style, notice: 'Stroke style was successfully created.' }
        format.json { render :show, status: :created, location: @stroke_style }
      else
        format.html { render :new }
        format.json { render json: @stroke_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stroke_styles/1
  # PATCH/PUT /stroke_styles/1.json
  def update
    respond_to do |format|
      if @stroke_style.update(stroke_style_params)
        format.html { redirect_to @stroke_style, notice: 'Stroke style was successfully updated.' }
        format.json { render :show, status: :ok, location: @stroke_style }
      else
        format.html { render :edit }
        format.json { render json: @stroke_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stroke_styles/1
  # DELETE /stroke_styles/1.json
  def destroy
    @stroke_style.destroy
    respond_to do |format|
      format.html { redirect_to stroke_styles_url, notice: 'Stroke style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def style_view
    # @sample_articles = StrokeStyle.make_sample_articles
    @sample_articles = StrokeStyle.sample_articles
  end

  def style_update
    StrokeStyle.update_sample_articles
    redirect_to stroke_styles_url
  end

  def save_current
    @stroke_style.save_current_styles_with_klass_key
    redirect_to stroke_styles_url,  notice: 'Current text style was successfully saved.'
  end

  # download story.pdf
  def download_pdf
    send_file @stroke_style.pdf_path, :type=>'application/pdf', :x_sendfile=>true, :disposition => "attachment"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stroke_style
      @stroke_style = StrokeStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stroke_style_params
      params.require(:stroke_style).permit(:klass, :name, :stroke, :publication_id)
    end
end
