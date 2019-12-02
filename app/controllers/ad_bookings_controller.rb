class AdBookingsController < ApplicationController
  before_action :set_ad_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /ad_bookings
  # GET /ad_bookings.json
  def index
    @ad_bookings = AdBooking.all
    
  end

  # GET /ad_bookings/1
  # GET /ad_bookings/1.json
  def show
  end

  # GET /ad_bookings/new
  def new
    @ad_booking = AdBooking.new
  end

  # GET /ad_bookings/1/edit
  def edit
  end

  # POST /ad_bookings
  # POST /ad_bookings.json
  def create
    @ad_booking = AdBooking.new(ad_booking_params)

    respond_to do |format|
      if @ad_booking.save
        format.html { redirect_to @ad_booking, notice: 'Ad booking was successfully created.' }
        format.json { render :show, status: :created, location: @ad_booking }
      else
        format.html { render :new }
        format.json { render json: @ad_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_bookings/1
  # PATCH/PUT /ad_bookings/1.json
  def update
    respond_to do |format|
      if @ad_booking.update(ad_booking_params)
        format.html { redirect_to @ad_booking, notice: 'Ad booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_booking }
      else
        format.html { render :edit }
        format.json { render json: @ad_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_bookings/1
  # DELETE /ad_bookings/1.json
  def destroy
    @ad_booking.destroy
    respond_to do |format|
      format.html { redirect_to ad_bookings_url, notice: 'Ad booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_booking
      @ad_booking = AdBooking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_booking_params
      params.require(:ad_booking).permit(:publication_id, :date, :ad_list)
    end
end
