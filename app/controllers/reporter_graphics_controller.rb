class ReporterGraphicsController < ApplicationController
  before_action :set_reporter_graphic, only: [:show, :edit, :update, :destroy, :download]

  # GET /reporter_graphics
  # GET /reporter_graphics.json
  def index
    @reporter_graphics = ReporterGraphic.page(params[:page]).per(20)
        # @issues = Issue.order(:id, 'DESC').page(params[:page]).per(20) 
  end

  # GET /reporter_graphics/1
  # GET /reporter_graphics/1.json
  def show
  end

  # GET /reporter_graphics/new
  def new
    @user = current_user
    @reporter_graphic = ReporterGraphic.new
  end

  # GET /reporter_graphics/1/edit
  def edit
  end

  # POST /reporter_graphics
  # POST /reporter_graphics.json
  def create
    @reporter_graphic = ReporterGraphic.new(reporter_graphic_params)

    respond_to do |format|
      if @reporter_graphic.save
        format.html { redirect_to @reporter_graphic, notice: 'Reporter graphic was successfully created.' }
        format.json { render :show, status: :created, location: @reporter_graphic }
      else
        format.html { render :new }
        format.json { render json: @reporter_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reporter_graphics/1
  # PATCH/PUT /reporter_graphics/1.json
  def update
    respond_to do |format|
      if @reporter_graphic.update(reporter_graphic_params)
        format.html { redirect_to @reporter_graphic, notice: 'Reporter graphic was successfully updated.' }
        format.json { render :show, status: :ok, location: @reporter_graphic }
      else
        format.html { render :edit }
        format.json { render json: @reporter_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporter_graphics/1
  # DELETE /reporter_graphics/1.json
  def destroy
    @reporter_graphic.destroy
    respond_to do |format|
      format.html { redirect_to reporter_graphics_url, notice: 'Reporter graphic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my
    @q = ReporterImage.ransack(params[:q])
    @reporter_graphics = @q.result(distinct: true)
    # @reporter_graphics = @reporter_images.order(:id).page(params[:page]).reverse_order.per(30)
    @reporter_graphics = current_user.reporter_graphics.order(id: 'DESC').page(params[:page]).per(20)
  end

  def download
    # puts "File.exist?(@reporter_graphic.full_size_full_path):#{File.exist?(@reporter_graphic.full_size_full_path)}"
    send_file @reporter_graphic.full_size_full_path, :x_sendfile=>true, :disposition => "attachment"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reporter_graphic
      @reporter_graphic = ReporterGraphic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reporter_graphic_params
      params.require(:reporter_graphic).permit(:user_id, :title, :caption, :source, :wire_pictures, :section_name, :used_in_layout, :finished_job, uploads: [])
    end
end
