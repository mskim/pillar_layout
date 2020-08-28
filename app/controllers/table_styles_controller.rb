class TableStylesController < ApplicationController
  before_action :set_table_style, only: [:show, :edit, :update, :destroy]

  # GET /table_styles
  # GET /table_styles.json
  def index
    @table_styles = TableStyle.all
  end

  # GET /table_styles/1
  # GET /table_styles/1.json
  def show
  end

  # GET /table_styles/new
  def new
    @table_style = TableStyle.new
  end

  # GET /table_styles/1/edit
  def edit
  end

  # POST /table_styles
  # POST /table_styles.json
  def create
    @table_style = TableStyle.new(table_style_params)

    respond_to do |format|
      if @table_style.save
        format.html { redirect_to @table_style, notice: 'Table style was successfully created.' }
        format.json { render :show, status: :created, location: @table_style }
      else
        format.html { render :new }
        format.json { render json: @table_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /table_styles/1
  # PATCH/PUT /table_styles/1.json
  def update
    respond_to do |format|
      if @table_style.update(table_style_params)
        format.html { redirect_to @table_style, notice: 'Table style was successfully updated.' }
        format.json { render :show, status: :ok, location: @table_style }
      else
        format.html { render :edit }
        format.json { render json: @table_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_styles/1
  # DELETE /table_styles/1.json
  def destroy
    @table_style.destroy
    respond_to do |format|
      format.html { redirect_to table_styles_url, notice: 'Table style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_style
      @table_style = TableStyle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def table_style_params
      params.require(:table_style).permit(:name, :column, :row, :heading_level, :category_level, :layout)
    end
end
