class GraphicRequestsController < ApplicationController
  before_action :set_graphic_request, only: [:show, :edit, :update, :destroy]

  # GET /graphic_requests
  # GET /graphic_requests.json
  def index
    @graphic_requests = GraphicRequest.all
    
  end

  # GET /graphic_requests/1
  # GET /graphic_requests/1.json
  def show
  end

  # GET /graphic_requests/new
  def new
    @graphic_request = GraphicRequest.new
  end

  # GET /graphic_requests/1/edit
  def edit
  end

  # POST /graphic_requests
  # POST /graphic_requests.json
  def create
    @graphic_request = GraphicRequest.new(graphic_request_params)
    @graphic_request.user= current_user

    respond_to do |format|
      if @graphic_request.save
        format.html { redirect_to @graphic_request, notice: 'Graphic request was successfully created.' }
        format.json { render :show, status: :created, location: @graphic_request }
      else
        format.html { render :new }
        format.json { render json: @graphic_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphic_requests/1
  # PATCH/PUT /graphic_requests/1.json
  def update
    respond_to do |format|
      if @graphic_request.update(graphic_request_params)
        format.html { redirect_to @graphic_request, notice: 'Graphic request was successfully updated.' }
        format.json { render :show, status: :ok, location: @graphic_request }
      else
        format.html { render :edit }
        format.json { render json: @graphic_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphic_requests/1
  # DELETE /graphic_requests/1.json
  def destroy
    @graphic_request.destroy
    respond_to do |format|
      format.html { redirect_to graphic_requests_url, notice: 'Graphic request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my
    @graphic_requests = current_user.graphic_requests.order(date: 'DESC')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graphic_request
      @graphic_request = GraphicRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graphic_request_params
      params.require(:graphic_request).permit(:date, :user_id, :designer, :request, :data, :status)
    end
end
