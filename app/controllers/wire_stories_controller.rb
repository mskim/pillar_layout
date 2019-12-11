class WireStoriesController < ApplicationController
  before_action :set_wire_story, only: [:show, :edit, :update, :destroy]

  # GET /wire_stories
  # GET /wire_stories.json
  def index
    @wire_stories = WireStory.all
  end

  # GET /wire_stories/1
  # GET /wire_stories/1.json
  def show
  end

  # GET /wire_stories/new
  def new
    @wire_story = WireStory.new
  end

  # GET /wire_stories/1/edit
  def edit
  end

  # POST /wire_stories
  # POST /wire_stories.json
  def create
    @wire_story = WireStory.new(wire_story_params)

    respond_to do |format|
      if @wire_story.save
        format.html { redirect_to @wire_story, notice: 'Wire story was successfully created.' }
        format.json { render :show, status: :created, location: @wire_story }
      else
        format.html { render :new }
        format.json { render json: @wire_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wire_stories/1
  # PATCH/PUT /wire_stories/1.json
  def update
    respond_to do |format|
      if @wire_story.update(wire_story_params)
        format.html { redirect_to @wire_story, notice: 'Wire story was successfully updated.' }
        format.json { render :show, status: :ok, location: @wire_story }
      else
        format.html { render :edit }
        format.json { render json: @wire_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wire_stories/1
  # DELETE /wire_stories/1.json
  def destroy
    @wire_story.destroy
    respond_to do |format|
      format.html { redirect_to wire_stories_url, notice: 'Wire story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wire_story
      @wire_story = WireStory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wire_story_params
      params.require(:wire_story).permit(:send_date, :content_id, :category_code, :category_name, :region_code, :region_name, :credit, :source, :title, :body, :issue_id)
    end
end
