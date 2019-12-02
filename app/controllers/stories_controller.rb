# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy assign_position un_assign_position backup recover_backup]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  # before_action :require_user # require_user will set the current_user in controllers
  # before_action :set_current_user

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.where(date: Issue.last.date, summitted: true).all
    @stories = Story.where(date: Issue.last.date).all
    # @ko_date = Issue.last.pages.first.korean_date_string
    @ko_date = Issue.last.korean_date_string
    respond_to do |format|
      format.html
      format.json { render json: StoryDatatable.new(params) }
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @working_article = @story.working_article
    @story.backup
    # redirect_to story_path(@story)
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit; end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user = current_user
    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        @story.working_article.update_story_content(@story) if @story.selected
        format.html { redirect_to @story, notice: '기사가 수정되었습니다!' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my
    @stories = current_user.stories.order(:updated_at).reverse
    # @stories = current_user.stories.order(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).reverse
  end

  def assign_position
    wa = WorkingArticle.find(params[:box])
    if wa
      @story.working_article_id = wa.id
      @story.order = wa.order
      @story.selected = true
      @story.save
      wa.update_story_content(@story)
    end
    case session[:current_story_group]
    when 'first_group'
      redirect_to first_group_stories_issue_path(Issue.last)
    when 'second_group'
      redirect_to second_group_stories_issue_path(Issue.last)
    when 'third_group'
      redirect_to third_group_stories_issue_path(Issue.last)
    when 'fourth_group'
      redirect_to fourth_group_stories_issue_path(Issue.last)
    when 'fifth_group'
      redirect_to fifth_group_stories_issue_path(Issue.last)
    when 'sixth_group'
      redirect_to sixth_group_stories_issue_path(Issue.last)
    when 'seventh_group'
      redirect_to seventh_group_stories_issue_path(Issue.last)
    when 'eighth_group'
      redirect_to eighth_group_stories_issue_path(Issue.last)
    when 'nineth_group'
      redirect_to nineth_group_stories_issue_path(Issue.last)
    else
      # redirect_to first_group_stories_issue_path(Issue.last)
      redirect_to eighth_group_stories_issue_path(Issue.last)
    end
  end

  def un_assign_position
    wa = WorkingArticle.find(params[:box])
    if wa
      wa.clear_story
      @story.working_article_id = nil
      @story.order = nil
      @story.selected = false
      @story.save
      # wa.update_story_content(@story)
    end
    case session[:current_story_group]
    when 'first_group'
      redirect_to first_group_stories_issue_path(Issue.last)
    when 'second_group'
      redirect_to second_group_stories_issue_path(Issue.last)
    when 'third_group'
      redirect_to third_group_stories_issue_path(Issue.last)
    when 'fourth_group'
      redirect_to fourth_group_stories_issue_path(Issue.last)
    when 'fifth_group'
      redirect_to fifth_group_stories_issue_path(Issue.last)
    when 'sixth_group'
      redirect_to sixth_group_stories_issue_path(Issue.last)
    when 'seventh_group'
      redirect_to seventh_group_stories_issue_path(Issue.last)
    when 'eighth_group'
      redirect_to eighth_group_stories_issue_path(Issue.last)
    when 'nineth_group'
      redirect_to nineth_group_stories_issue_path(Issue.last)
    else
      # redirect_to first_group_stories_issue_path(Issue.last)
      redirect_to eighth_group_stories_issue_path(Issue.last)
    end
  end

  def backup
    @story.backup
    redirect_to story_path(@story)
  end

  def recover_backup
    @story.recover_backup
    redirect_to story_path(@story)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def story_params
    params.require(:story).permit(:user_id, :working_article_id, :reporter, :group, :date, :subject_head, :title, :subtitle, :body, :quote, :status, :summitted_section, :char_count, :published, :path, :category_code, :price, :content, story_type: [])
  end
end
