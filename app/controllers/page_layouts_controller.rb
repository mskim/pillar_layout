class PageLayoutsController < ApplicationController
  before_action :set_page_layout, only: [:show, :edit, :update, :destroy]

  # GET /page_layouts
  # GET /page_layouts.json
  def index
    @page_layouts = PageLayout.all.order(:ad_type)
  end

  # GET /page_layouts/1
  # GET /page_layouts/1.json
  def show
  end

  # GET /page_layouts/new
  def new
    @page_layout = PageLayout.new
  end

  # GET /page_layouts/1/edit
  def edit
  end

  # POST /page_layouts
  # POST /page_layouts.json
  def create
    @page_layout = PageLayout.new(page_layout_params)

    respond_to do |format|
      if @page_layout.save
        format.html { redirect_to @page_layout, notice: 'Page layout was successfully created.' }
        format.json { render :show, status: :created, location: @page_layout }
      else
        format.html { render :new }
        format.json { render json: @page_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_layouts/1
  # PATCH/PUT /page_layouts/1.json
  def update
    respond_to do |format|
      # binding.pry
      # page_layout_params['layout'] = eval(page_layout_params['layout'])
      # binding.pry
      if @page_layout.update(page_layout_params)
        format.html { redirect_to @page_layout, notice: 'Page layout was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_layout }
      else
        format.html { render :edit }
        format.json { render json: @page_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_layouts/1
  # DELETE /page_layouts/1.json
  def destroy
    @page_layout.destroy
    respond_to do |format|
      format.html { redirect_to page_layouts_url, notice: 'Page layout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_layout
      @page_layout = PageLayout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_layout_params
      params.require(:page_layout).permit(:doc_width, :doc_height, :ad_type, :page_type, :column, :row, :pillar_count, :grid_width, :grid_height, :gutter, :margin, :like, :layout_with_pillar_path=>[], :layout=>[])
    end
end
