class PageHeadingKindsController < ApplicationController
  before_action :set_page_heading_kind, only: %i[ show edit update destroy ]

  # GET /page_heading_kinds or /page_heading_kinds.json
  def index
    @page_heading_kinds = PageHeadingKind.all
  end

  # GET /page_heading_kinds/1 or /page_heading_kinds/1.json
  def show
  end

  # GET /page_heading_kinds/new
  def new
    @page_heading_kind = PageHeadingKind.new
  end

  # GET /page_heading_kinds/1/edit
  def edit
  end

  # POST /page_heading_kinds or /page_heading_kinds.json
  def create
    @page_heading_kind = PageHeadingKind.new(page_heading_kind_params)

    respond_to do |format|
      if @page_heading_kind.save
        format.html { redirect_to @page_heading_kind, notice: "Page heading kind was successfully created." }
        format.json { render :show, status: :created, location: @page_heading_kind }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page_heading_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_heading_kinds/1 or /page_heading_kinds/1.json
  def update
    respond_to do |format|
      if @page_heading_kind.update(page_heading_kind_params)
        format.html { redirect_to @page_heading_kind, notice: "Page heading kind was successfully updated." }
        format.json { render :show, status: :ok, location: @page_heading_kind }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page_heading_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_heading_kinds/1 or /page_heading_kinds/1.json
  def destroy
    @page_heading_kind.destroy
    respond_to do |format|
      format.html { redirect_to page_heading_kinds_url, notice: "Page heading kind was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_heading_kind
      @page_heading_kind = PageHeadingKind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_heading_kind_params
      params.require(:page_heading_kind).permit(:publication, :page_type, :layout_erb, :height_in_lines, :bg_image)
    end
end
