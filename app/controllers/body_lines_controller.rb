class BodyLinesController < ApplicationController
  before_action :set_body_line, only: [:show, :edit, :update, :destroy]

  # GET /body_lines
  # GET /body_lines.json
  def index
    @body_lines = BodyLine.all
  end

  # GET /body_lines/1
  # GET /body_lines/1.json
  def show
  end

  # GET /body_lines/new
  def new
    @body_line = BodyLine.new
  end

  # GET /body_lines/1/edit
  def edit
  end

  # POST /body_lines
  # POST /body_lines.json
  def create
    @body_line = BodyLine.new(body_line_params)

    respond_to do |format|
      if @body_line.save
        format.html { redirect_to @body_line, notice: 'Body line was successfully created.' }
        format.json { render :show, status: :created, location: @body_line }
      else
        format.html { render :new }
        format.json { render json: @body_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /body_lines/1
  # PATCH/PUT /body_lines/1.json
  def update
    respond_to do |format|
      if @body_line.update(body_line_params)
        format.html { redirect_to @body_line, notice: 'Body line was successfully updated.' }
        format.json { render :show, status: :ok, location: @body_line }
      else
        format.html { render :edit }
        format.json { render json: @body_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_lines/1
  # DELETE /body_lines/1.json
  def destroy
    @body_line.destroy
    respond_to do |format|
      format.html { redirect_to body_lines_url, notice: 'Body line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body_line
      @body_line = BodyLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def body_line_params
      params.require(:body_line).permit(:order, :x, :y, :width, :height, :coulumn, :line_number, :tokens, :overflow, :working_aticle_id)
    end
end
