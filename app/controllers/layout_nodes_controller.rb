class LayoutNodesController < ApplicationController
  before_action :set_layout_node, only: [:show, :edit, :update, :destroy]

  # GET /layout_nodes
  # GET /layout_nodes.json
  def index
    @layout_nodes = LayoutNode.all
  end

  # GET /layout_nodes/1
  # GET /layout_nodes/1.json
  def show
  end

  # GET /layout_nodes/new
  def new
    @layout_node = LayoutNode.new
  end

  # GET /layout_nodes/1/edit
  def edit
  end

  # POST /layout_nodes
  # POST /layout_nodes.json
  def create
    @layout_node = LayoutNode.new(layout_node_params)

    respond_to do |format|
      if @layout_node.save
        format.html { redirect_to @layout_node, notice: 'Layout node was successfully created.' }
        format.json { render :show, status: :created, location: @layout_node }
      else
        format.html { render :new }
        format.json { render json: @layout_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /layout_nodes/1
  # PATCH/PUT /layout_nodes/1.json
  def update
    respond_to do |format|
      if @layout_node.update(layout_node_params)
        format.html { redirect_to @layout_node, notice: 'Layout node was successfully updated.' }
        format.json { render :show, status: :ok, location: @layout_node }
      else
        format.html { render :edit }
        format.json { render json: @layout_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layout_nodes/1
  # DELETE /layout_nodes/1.json
  def destroy
    @layout_node.destroy
    respond_to do |format|
      format.html { redirect_to layout_nodes_url, notice: 'Layout node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_layout_node
      @layout_node = LayoutNode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def layout_node_params
      params.require(:layout_node).permit(:direction, :grid_x, :grid_y, :column, :row, :profile, :node_kind, :tag, :selected, :actions, :layout, :layout_with_pillar_path, :box_count)
    end
end
