class YhPhotoFrYnasController < ApplicationController
  before_action :set_yh_photo_fr_yna, only: [:show, :edit, :update, :destroy, :taken]

  # GET /yh_photo_fr_ynas
  # GET /yh_photo_fr_ynas.json
  def index
    @q = YhPhotoFrYna.ransack(params[:q])
    @yh_photo_fr_ynas = @q.result
    session[:current_yh_picture_category] = params[:q]['category_cont'] if params[:q]
    @yh_photo_fr_ynas = @yh_photo_fr_ynas.order(:date).page(params[:page]).reverse_order.per(18)
  
    # @yh_photo_fr_ynas = YhPhotoFrYna.all
  end
  
  # GET /yh_photo_fr_ynas/1
  # GET /yh_photo_fr_ynas/1.json
  def show
  end
  
  # GET /yh_photo_fr_ynas/new
  def new
    @yh_photo_fr_yna = YhPhotoFrYna.new
  end
  
  # GET /yh_photo_fr_ynas/1/edit
  def edit
  end
  
  # POST /yh_photo_fr_ynas
  # POST /yh_photo_fr_ynas.json
  def create
    @yh_photo_fr_yna = YhPhotoFrYna.new(yh_photo_fr_yna_params)
  
    respond_to do |format|
      if @yh_photo_fr_yna.save
        format.html { redirect_to @yh_photo_fr_yna, notice: 'Yh photo tr was successfully created.' }
        format.json { render :show, status: :created, location: @yh_photo_fr_yna }
      else
        format.html { render :new }
        format.json { render json: @yh_photo_fr_yna.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /yh_photo_fr_ynas/1
  # PATCH/PUT /yh_photo_fr_ynas/1.json
  def update
    respond_to do |format|
      if @yh_photo_fr_yna.update(yh_photo_fr_yna_params)
        format.html { redirect_to @yh_photo_fr_yna, notice: 'Yh photo tr was successfully updated.' }
        format.json { render :show, status: :ok, location: @yh_photo_fr_yna }
      else
        format.html { render :edit }
        format.json { render json: @yh_photo_fr_yna.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /yh_photo_fr_ynas/1
  # DELETE /yh_photo_fr_ynas/1.json
  def destroy
    @yh_photo_fr_yna.destroy
    respond_to do |format|
      format.html { redirect_to yh_photo_fr_ynas_url, notice: 'Yh photo tr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def taken
    ReporterImage.image_from_wire(current_user, @yh_photo_fr_yna)
    redirect_to my_reporter_images_path, notice: '나의 사진으로 등록 되었습니다.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yh_photo_fr_yna
      @yh_photo_fr_yna = YhPhotoFrYna.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def yh_photo_fr_yna_params
      params.require(:yh_photo_fr_yna).permit(:action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :page_ref, :title, :comment, :body, :picture, :taken_by)
    end
  end