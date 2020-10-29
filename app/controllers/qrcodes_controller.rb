class QrcodesController < ApplicationController
  before_action :set_qrcode, only: [:show, :edit, :update, :destroy]

  # GET /qrcodes
  # GET /qrcodes.json
  def index
    @qrcodes = Qrcode.all
  end

  # GET /qrcodes/1
  # GET /qrcodes/1.json
  def show
  end

  # GET /qrcodes/new
  def new
    @qrcode = Qrcode.new
  end

  # GET /qrcodes/1/edit
  def edit
  end

  # POST /qrcodes
  # POST /qrcodes.json
  def create
    @qrcode = Qrcode.new(qrcode_params)

    respond_to do |format|
      if @qrcode.save
        format.html { redirect_to @qrcode, notice: 'Qrcode was successfully created.' }
        format.json { render :show, status: :created, location: @qrcode }
      else
        format.html { render :new }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qrcodes/1
  # PATCH/PUT /qrcodes/1.json
  def update
    respond_to do |format|
      if @qrcode.update(qrcode_params)
        format.html { redirect_to @qrcode, notice: 'Qrcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @qrcode }
      else
        format.html { render :edit }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcodes/1
  # DELETE /qrcodes/1.json
  def destroy
    @qrcode.destroy
    respond_to do |format|
      format.html { redirect_to qrcodes_url, notice: 'Qrcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qrcode
      @qrcode = Qrcode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qrcode_params
      params.require(:qrcode).permit(:x, :y, :width, :height, :qr_text, :qrcode_file, :qrcode_type, :web_page_id)
    end
end
