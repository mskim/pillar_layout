class ExepertWritersController < ApplicationController
  before_action :set_exepert_writer, only: [:show, :edit, :update, :destroy]

  # GET /exepert_writers
  # GET /exepert_writers.json
  def index
    @exepert_writers = ExeprtWriter.all
  end

  # GET /exepert_writers/1
  # GET /exepert_writers/1.json
  def show
  end

  # GET /exepert_writers/new
  def new
    @exeprt_writer = ExeprtWriter.new
  end

  # GET /exepert_writers/1/edit
  def edit
  end

  # POST /exepert_writers
  # POST /exepert_writers.json
  def create
    @exeprt_writer = ExeprtWriter.new(exeprt_writer_params)

    respond_to do |format|
      if @exeprt_writer.save
        format.html { redirect_to @exeprt_writer, notice: 'Exeprt writer was successfully created.' }
        format.json { render :show, status: :created, location: @exeprt_writer }
      else
        format.html { render :new }
        format.json { render json: @exeprt_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exepert_writers/1
  # PATCH/PUT /exepert_writers/1.json
  def update
    respond_to do |format|
      if @exeprt_writer.update(exeprt_writer_params)
        format.html { redirect_to @exeprt_writer, notice: 'Exeprt writer was successfully updated.' }
        format.json { render :show, status: :ok, location: @exeprt_writer }
      else
        format.html { render :edit }
        format.json { render json: @exeprt_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exepert_writers/1
  # DELETE /exepert_writers/1.json
  def destroy
    @exeprt_writer.destroy
    respond_to do |format|
      format.html { redirect_to exepert_writers_url, notice: 'Exeprt writer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exeprt_writer
      @exeprt_writer = ExeprtWriter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exeprt_writer_params
      params.require(:exeprt_writer).permit(:name, :work, :position, :email, :category_code, :expert_image, :expert_jpg_image)
    end
end
