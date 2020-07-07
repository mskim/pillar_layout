class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy, :download_pdf, :heading_bg_images]
  before_action :authenticate_user!

  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        @publication.generate_sample_pdf
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Publication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # download story.pdf
  def download_pdf
    send_file @publication.pdf_path, :type=>'application/pdf', :x_sendfile=>true, :disposition => "attachment"
  end

  def heading_bg_images

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:name, :paper_size, :width, :width_in_unit, :height, :height_in_unit, :left_margin, :left_margin_in_unit, :top_margin, :top_margin_in_unit, :right_margin, :right_margin_in_unit, :bottom_margin, :bottom_margin_in_unit, :lines_per_grid, :gutter, :gutter_in_unit, :page_count, :section_names, :page_columns, :row, :front_page_heading_height, :inner_page_heading_height, :inner_page_heading_height, :article_bottom_spaces_in_lines, :article_line_draw_sides, :article_line_thickness, :draw_divider)
    end
end
