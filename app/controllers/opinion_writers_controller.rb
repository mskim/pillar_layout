class OpinionWritersController < ApplicationController
  before_action :set_opinion_writer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /opinion_writers
  # GET /opinion_writers.json
  def index
    @q = OpinionWriter.ransack(params[:q])
    @opinion_writers = @q.result
    @opinion_writers = OpinionWriter.all  if request.format == 'csv'
    

    respond_to do |format|
      format.html
      format.csv do
        writers = OpinionWriter.order(name: :desc).all
        send_data @opinion_writers.to_csv
      end
    end
  end

  # GET /opinion_writers/1
  # GET /opinion_writers/1.json
  def show
  end

  # GET /opinion_writers/new
  def new
    @opinion_writer = OpinionWriter.new
  end

  # GET /opinion_writers/1/edit
  def edit
  end

  # POST /opinion_writers
  # POST /opinion_writers.json
  def create
    @opinion_writer = OpinionWriter.new(opinion_writer_params)

    respond_to do |format|
      if @opinion_writer.save
        @opinion_writer.generate_pdf
        format.html { redirect_to @opinion_writer, notice: '오피니언 저자가 생성 되었습니다.' }
        format.json { render :show, status: :created, location: @opinion_writer }
      else
        format.html { render :new }
        format.json { render json: @opinion_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinion_writers/1
  # PATCH/PUT /opinion_writers/1.json
  def update
    respond_to do |format|
      if @opinion_writer.update(opinion_writer_params)
        @opinion_writer.generate_pdf
        format.html { redirect_to @opinion_writer, notice: '오피니언 저자가 수정 되었습니다.' }
        format.json { render :show, status: :ok, location: @opinion_writer }
      else
        format.html { render :edit }
        format.json { render json: @opinion_writer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinion_writers/1
  # DELETE /opinion_writers/1.json
  def destroy
    @opinion_writer.destroy
    respond_to do |format|
      format.html { redirect_to opinion_writers_url, notice: '오피니언 저자가 삭제 되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion_writer
      @opinion_writer = OpinionWriter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opinion_writer_params
      params.require(:opinion_writer).permit(:name, :opinion_image, :opinion_jpg_image, :title, :work, :position, :email, :publication_id, :category_code)
    end
end
