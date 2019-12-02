class StorySubcategoriesController < ApplicationController
  before_action :set_story_subcategory, only: [:show, :edit, :update, :destroy]

  # GET /story_subcategories
  # GET /story_subcategories.json
  def index
    @story_subcategories = StorySubcategory.all
  end

  # GET /story_subcategories/1
  # GET /story_subcategories/1.json
  def show
  end

  # GET /story_subcategories/new
  def new
    @story_subcategory = StorySubcategory.new
  end

  # GET /story_subcategories/1/edit
  def edit
  end

  # POST /story_subcategories
  # POST /story_subcategories.json
  def create
    @story_subcategory = StorySubcategory.new(story_subcategory_params)

    respond_to do |format|
      if @story_subcategory.save
        format.html { redirect_to @story_subcategory, notice: 'Story subcategory was successfully created.' }
        format.json { render :show, status: :created, location: @story_subcategory }
      else
        format.html { render :new }
        format.json { render json: @story_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /story_subcategories/1
  # PATCH/PUT /story_subcategories/1.json
  def update
    respond_to do |format|
      if @story_subcategory.update(story_subcategory_params)
        format.html { redirect_to @story_subcategory, notice: 'Story subcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @story_subcategory }
      else
        format.html { render :edit }
        format.json { render json: @story_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /story_subcategories/1
  # DELETE /story_subcategories/1.json
  def destroy
    @story_subcategory.destroy
    respond_to do |format|
      format.html { redirect_to story_subcategories_url, notice: 'Story subcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_subcategory
      @story_subcategory = StorySubcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_subcategory_params
      params.require(:story_subcategory).permit(:name, :code, :story_category_id)
    end
end
