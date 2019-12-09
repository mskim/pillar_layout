class YhGraphicsController < ApplicationController
  before_action :set_yh_graphic, only: [:show, :edit, :update, :destroy, :taken]

  # GET /yh_graphics
  # GET /yh_graphics.json
  def index
    @q = YhGraphic.ransack(params[:q])
    @yh_graphics = @q.result
    session[:current_yh_graphic_category] = params[:q]['category_cont'] if params[:q]
    @yh_graphics = @yh_graphics.order(:date).page(params[:page]).reverse_order.per(20)
    # @yh_graphics = YhGraphic.all
  end

  # GET /yh_graphics/1
  # GET /yh_graphics/1.json
  def show
  end

  # GET /yh_graphics/new
  def new
    @yh_graphic = YhGraphic.new
  end

  # GET /yh_graphics/1/edit
  def edit
  end

  # POST /yh_graphics
  # POST /yh_graphics.json
  def create
    @yh_graphic = YhGraphic.new(yh_graphic_params)

    respond_to do |format|
      if @yh_graphic.save
        format.html { redirect_to @yh_graphic, notice: 'Yh graphic was successfully created.' }
        format.json { render :show, status: :created, location: @yh_graphic }
      else
        format.html { render :new }
        format.json { render json: @yh_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yh_graphics/1
  # PATCH/PUT /yh_graphics/1.json
  def update
    respond_to do |format|
      if @yh_graphic.update(yh_graphic_params)
        format.html { redirect_to @yh_graphic, notice: 'Yh graphic was successfully updated.' }
        format.json { render :show, status: :ok, location: @yh_graphic }
      else
        format.html { render :edit }
        format.json { render json: @yh_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yh_graphics/1
  # DELETE /yh_graphics/1.json
  def destroy
    @yh_graphic.destroy
    respond_to do |format|
      format.html { redirect_to yh_graphics_url, notice: '그래픽 삭제 되었습니다.' }
      format.json { head :no_content }
    end
  end

  def taken
    ReporterGraphic.graphic_from_wire(current_user, @yh_graphic)
    redirect_to my_reporter_graphics_path, notice: '나의 사진으로 등록 되었습니다.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yh_graphic
      @yh_graphic = YhGraphic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def yh_graphic_params
      params.require(:yh_graphic).permit(:action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :page_ref, :title, :comment, :body, :picture, :taken_by)
    end
end
