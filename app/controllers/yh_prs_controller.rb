class YhPrsController < ApplicationController
  before_action :set_yh_pr, only: [:show, :edit, :update, :destroy, :taken]

  # GET /yh_pr
  # GET /yh_pr.json
  def index
    @q = YhPr.ransack(params[:q])
    @yh_prs = @q.result
    session[:current_yh_pr_category] = params[:q]['category_cont'] if params[:q]
    @yh_prs = @yh_prs.order(:date).page(params[:page]).reverse_order.per(18)

    # @yh_pr = YhPr.all
  end

  # GET /yh_prs/1
  # GET /yh_prs/1.json
  def show
  end

  # GET /yh_pr/new
  def new
    @yh_pr = YhPr.new
  end

  # GET /yh_pr/1/edit
  def edit
  end

  # POST /yh_pr
  # POST /yh_pr.json
  def create
    @yh_pr = YhPr.new(yh_pr_params)

    respond_to do |format|
      if @yh_pr.save
        format.html { redirect_to @yh_pr, notice: 'Yh picture was successfully created.' }
        format.json { render :show, status: :created, location: @yh_pr }
      else
        format.html { render :new }
        format.json { render json: @yh_pr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yh_pr/1
  # PATCH/PUT /yh_pr/1.json
  def update
    respond_to do |format|
      if @yh_pr.update(yh_pr_params)
        format.html { redirect_to @yh_pr, notice: 'Yh picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @yh_pr }
      else
        format.html { render :edit }
        format.json { render json: @yh_pr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yh_pr/1
  # DELETE /yh_pr/1.json
  def destroy
    @yh_pr.destroy
    respond_to do |format|
      format.html { redirect_to yh_pr_url, notice: 'Yh picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def taken
    @yh_pr.taken(current_user)
    ReporterImage.image_from_wire(current_user, @yh_pr)
    redirect_to my_reporter_images_path(@yh_pr), notice: '나의 사진으로 등록 되었습니다.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yh_pr
      @yh_pr = YhPr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def yh_pr_params
      params.require(:yh_pr).permit(:action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :region, :title, :comment, :body, :file_name, :taken_by)
    end
end
