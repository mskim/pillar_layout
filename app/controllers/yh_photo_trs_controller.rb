class YhPhotoTrsController < ApplicationController
  before_action :set_yh_photo_tr, only: [:show, :edit, :update, :destroy, :taken]

  # GET /yh_photo_trs
  # GET /yh_photo_trs.json
  def index
    @q = YhPhotoTr.ransack(params[:q])
    @yh_photo_trs = @q.result
    session[:current_yh_picture_category] = params[:q]['category_cont'] if params[:q]
    @yh_photo_trs = @yh_photo_trs.order(:date).page(params[:page]).reverse_order.per(18)

    # @yh_photo_trs = YhPhotoTr.all
  end

  # GET /yh_photo_trs/1
  # GET /yh_photo_trs/1.json
  def show
  end

  # GET /yh_photo_trs/new
  def new
    @yh_photo_tr = YhPhotoTr.new
  end

  # GET /yh_photo_trs/1/edit
  def edit
  end

  # POST /yh_photo_trs
  # POST /yh_photo_trs.json
  def create
    @yh_photo_tr = YhPhotoTr.new(yh_photo_tr_params)

    respond_to do |format|
      if @yh_photo_tr.save
        format.html { redirect_to @yh_photo_tr, notice: 'Yh photo tr was successfully created.' }
        format.json { render :show, status: :created, location: @yh_photo_tr }
      else
        format.html { render :new }
        format.json { render json: @yh_photo_tr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yh_photo_trs/1
  # PATCH/PUT /yh_photo_trs/1.json
  def update
    respond_to do |format|
      if @yh_photo_tr.update(yh_photo_tr_params)
        format.html { redirect_to @yh_photo_tr, notice: 'Yh photo tr was successfully updated.' }
        format.json { render :show, status: :ok, location: @yh_photo_tr }
      else
        format.html { render :edit }
        format.json { render json: @yh_photo_tr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yh_photo_trs/1
  # DELETE /yh_photo_trs/1.json
  def destroy
    @yh_photo_tr.destroy
    respond_to do |format|
      format.html { redirect_to yh_photo_trs_url, notice: 'Yh photo tr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def taken
    ReporterImage.image_from_wire(current_user, @yh_photo_tr)
    redirect_to my_reporter_images_path, notice: '나의 사진으로 등록 되었습니다.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yh_photo_tr
      @yh_photo_tr = YhPhotoTr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def yh_photo_tr_params
      params.require(:yh_photo_tr).permit(:action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :page_ref, :title, :comment, :body, :picture, :taken_by)
    end
end
