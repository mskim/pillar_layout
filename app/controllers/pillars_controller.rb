class PillarsController < ApplicationController
  before_action :set_pillar, only: [:show, :edit, :update, :destroy, :change_layout, :add_article, :remove_last_article]

  # GET /pillars
  # GET /pillars.json
  def index
    @pillars = Pillar.all
  end

  # GET /pillars/1
  # GET /pillars/1.json
  def show
  end

  # GET /pillars/new
  def new
    @pillar = Pillar.new
  end

  # GET /pillars/1/edit
  def edit
  end

  # POST /pillars
  # POST /pillars.json
  def create
    @pillar = Pillar.new(pillar_params)

    respond_to do |format|
      if @pillar.save
        format.html { redirect_to @pillar, notice: 'Pillar was successfully created.' }
        format.json { render :show, status: :created, location: @pillar }
      else
        format.html { render :new }
        format.json { render json: @pillar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pillars/1
  # PATCH/PUT /pillars/1.json
  def update
    respond_to do |format|
      if @pillar.update(pillar_params)
        format.html { redirect_to @pillar, notice: 'Pillar was successfully updated.' }
        format.json { render :show, status: :ok, location: @pillar }
      else
        format.html { render :edit }
        format.json { render json: @pillar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pillars/1
  # DELETE /pillars/1.json
  def destroy
    @pillar.destroy
    respond_to do |format|
      format.html { redirect_to pillars_url, notice: 'Pillar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /pillars/1/change_layout
  def change_layout
    new_choice  = params[:new_choice]
    node        = LayoutNode.find(new_choice)
    new_layout  = node.layout_with_pillar_path
    @pillar.change_layout(new_layout)
    redirect_to @pillar.page
  end

  def add_article
    @page = @pillar.page
    @pillar.add_article
    redirect_to @page
  end

  def remove_last_article
    @page = @pillar.page
    @pillar.remove_last_article
    redirect_to @page
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pillar
      @pillar = Pillar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pillar_params
      params.require(:pillar).permit(:grid_x, :grid_y, :column, :row, :order, :box_count, :layout_with_pillar_path, :layout, :profile, :finger_print, :page_ref_id, :page_ref_type)
    end
end
