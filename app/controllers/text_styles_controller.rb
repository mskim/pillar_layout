class TextStylesController < ApplicationController
  before_action :set_text_style, only: [:show, :edit, :update, :destroy, :save_current, :duplicate, :download_pdf]
  before_action :authenticate_user!

  # GET /text_styles
  # GET /text_styles.json
  def index
    @text_styles = TextStyle.order(korean_name: :desc).all
    respond_to do |format|
      format.html
      format.csv { send_data @text_styles.to_csv }
      
    end
  end

  # GET /text_styles/1
  # GET /text_styles/1.json
  def show
    
  end

  # GET /text_styles/new
  def new
    @text_style = TextStyle.new
  end

  # GET /text_styles/1/edit
  def edit
  end

  # POST /text_styles
  # POST /text_styles.json
  def create
    @text_style = TextStyle.new(text_style_params)

    respond_to do |format|
      if @text_style.save
        format.html { redirect_to @text_style, notice: 'Text style was successfully created.' }
        format.json { render :show, status: :created, location: @text_style }
      else
        format.html { render :new }
        format.json { render json: @text_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_styles/1
  # PATCH/PUT /text_styles/1.json
  def update
    respond_to do |format|
      if @text_style.update(text_style_params)
        @text_style.generate_pdf
        format.html { redirect_to @text_style, notice: 'Text style was successfully updated.' }
        format.json { render :show, status: :ok, location: @text_style }
      else
        format.html { render :edit }
        format.json { render json: @text_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_styles/1
  # DELETE /text_styles/1.json
  def destroy
    @text_style.destroy
    respond_to do |format|
      format.html { redirect_to text_styles_url, notice: 'Text style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def style_view
    # @sample_articles = TextStyle.make_sample_articles
    @sample_articles = TextStyle.sample_articles
  end

  def style_update
    TextStyle.update_sample_articles
    redirect_to text_styles_url
  end

  def save_current
    # @text_style.save_current_styles_with_english_key
    TextStyle.save_text_styles
    redirect_to text_styles_url,  notice: 'Current text style was successfully saved.'
  end

  # download story.pdf
  def download_pdf
    send_file @text_style.pdf_path, :type=>'application/pdf', :x_sendfile=>true, :disposition => "attachment"
  end

  def duplicate
    # @new_section = Section.new(@section.attributes)
    @new_text_style = TextStyle.create(@text_style.attributes.merge({id: nil }))
    respond_to do |format|
      if @new_text_style
          format.html { redirect_to text_styles_path, notice: 'TextStyle was successfully duplicated.'}
      else
        format.html { redirect_to sections_url, notice: 'Section could not be duplicated.' }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_style
      @text_style = TextStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_style_params
      params.require(:text_style).permit(:korean_name, :english, :font_family, :font, :font_size, :alignment, :text_color, :tracking, :space_width, :scale, :text_line_spacing, :space_before_in_lines, :text_height_in_lines, :space_after_in_lines, :box_attributes, :graphic_attributes, :markup, :publication_id)
    end
end
