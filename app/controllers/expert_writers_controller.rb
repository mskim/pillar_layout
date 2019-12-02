class ExpertWritersController < ApplicationController
  before_action :set_expert_writer, only: [:show, :edit, :update, :destroy]

  # GET /expert_writers
  # GET /expert_writers.json
  def index
    @expert_writers = ExpertWriter.all
  end

  # GET /expert_writers/1
  # GET /expert_writers/1.json
  def show
  end

  # GET /expert_writers/new
  def new
    @expert_writer = ExpertWriter.new
  end

  # GET /expert_writers/1/edit
  def edit
  end

  # POST /expert_writers
  # POST /expert_writers.json
  def create
    @expert_writer = ExpertWriter.new(expert_writer_params)

    respond_to do |format|
      if @expert_writer.save
        format.html { redirect_to @expert_writer, notice: 'Expert writer was successfully created.' }
        format.json { render :show, status: :created, location: @expert_writer }
      else
        format.html { render :new }
        format.json { render json: @expert_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expert_writers/1
  # PATCH/PUT /expert_writers/1.json
  def update
    respond_to do |format|
      if @expert_writer.update(expert_writer_params)
        format.html { redirect_to @expert_writer, notice: 'Expert writer was successfully updated.' }
        format.json { render :show, status: :ok, location: @expert_writer }
      else
        format.html { render :edit }
        format.json { render json: @expert_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expert_writers/1
  # DELETE /expert_writers/1.json
  def destroy
    @expert_writer.destroy
    respond_to do |format|
      format.html { redirect_to expert_writers_url, notice: 'Expert writer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert_writer
      @expert_writer = ExpertWriter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expert_writer_params
      params.require(:expert_writer).permit(:name, :work, :position, :email, :category_code, :expert_image, :expert_jpg_image)
    end
end
