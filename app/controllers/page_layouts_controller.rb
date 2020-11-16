class PageLayoutsController < ApplicationController
  before_action :set_page_layout, only: [:show, :edit, :update, :destroy, :duplicate]

  # GET /page_layouts
  # GET /page_layouts.json
  def index
    if params[:page]
      session[:current_section_pagination] = params[:page]
    end
    @q            = PageLayout.ransack(params[:q])
    @page_layouts = @q.result.order(:updated_at, :ad_type, :page_type, :column).page(params[:page]).reverse_order.per(10) 
    # ↓ pagy 작성하기 위해 임시로 주식 달았음(2020.11.15)
    # @page_layouts = PageLayout.all.order(:id) if request.format == 'csv'
    @pagy, @page_layouts = pagy(PageLayout.all.order(:id), items: 10)
    respond_to do |format|
      format.html 
      format.json { render :index }
      format.csv { send_data @page_layouts.to_csv }
    end
  end

  # GET /page_layouts/1
  # GET /page_layouts/1.json
  def show
  end

  # GET /page_layouts/new
  def new
    if params['duplicated']
      atts = YAML::load(params['duplicated'])
      @page_layout = PageLayout.new(atts)
    else
      @page_layout = PageLayout.new
    end
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
      # page_layout_params['layout'] = eval(page_layout_params['layout'])
      # check if there exist? edited template
      # redirect to format.html { render :edit }
      # else create new page_layout
      if @page_layout.update(page_layout_params)
        @page_layout.update_pillar_from_layout
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

  def duplicate
    # @new_section = Section.new(@section.attributes)
    atts = @page_layout.attributes.merge({'id'=> nil, 'created_at' =>nil, 'updated_at'=>nil})
    atts_yml = atts.to_yaml
    respond_to do |format|
      format.html { redirect_to new_page_layout_path(duplicated: atts_yml)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_layout
      @page_layout = PageLayout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_layout_params
      params.require(:page_layout).permit(:doc_width, :doc_height, :ad_type, :page_type, :column, :row, :pillar_count, :grid_width, :grid_height, :gutter, :margin, :like, :layout)
    end
end
