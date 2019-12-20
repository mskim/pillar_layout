# frozen_string_literal: true

class YhArticlesController < ApplicationController
  before_action :set_yh_article, only: %i[show edit update destroy taken]

  # GET /yh_articles
  # GET /yh_articles.json
  def index
    @q = YhArticle.ransack(params[:q])
    @yh_articles = @q.result(distinct: true)
    @yh_articles = @yh_articles.order(:date, :time).page(params[:page]).reverse_order.per(25)

    # @yh_articles = YhArticle.all
    # @yh_article_categories = YhArticle.pluck(:category_name).uniq.sort
    # @yh_article_categories = ["전체", "정치", "사회", "국제", "경제", "지방", "문화", "스포츠/레저", "기타"]
  end

  # GET /yh_articles/1
  # GET /yh_articles/1.json
  def show
    # 해당 게시물
    @yh_article = YhArticle.find(params[:id])
    # 검색 목록
    @q = YhArticle.ransack(params[:q])
    @yh_articles = @q.result.order(:date, :time).page(params[:page]).reverse_order.per(25)
  end

  # GET /yh_articles/new
  def new
    @yh_article = YhArticle.new
  end

  # GET /yh_articles/1/edit
  def edit; end

  # POST /yh_articles
  # POST /yh_articles.json
  def create
    @yh_article = YhArticle.new(yh_article_params)

    respond_to do |format|
      if @yh_article.save
        format.html { redirect_to @yh_article, notice: 'Yh article was successfully created.' }
        format.json { render :show, status: :created, location: @yh_article }
      else
        format.html { render :new }
        format.json { render json: @yh_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yh_articles/1
  # PATCH/PUT /yh_articles/1.json
  def update
    respond_to do |format|
      if @yh_article.update(yh_article_params)
        format.html { redirect_to @yh_article, notice: 'Yh article was successfully updated.' }
        format.json { render :show, status: :ok, location: @yh_article }
      else
        format.html { render :edit }
        format.json { render json: @yh_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yh_articles/1
  # DELETE /yh_articles/1.json
  def destroy
    @yh_article.destroy
    respond_to do |format|
      format.html { redirect_to yh_articles_url, notice: 'Yh article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def taken
    Story.story_from_wire(current_user, @yh_article)
    redirect_to my_stories_path(@yh_article), notice: '성공적으로 나의 기사로 저장되었습니다!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_yh_article
    @yh_article = YhArticle.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def yh_article_params
    params.require(:yh_article).permit(:action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :region, :title, :body, :writer, :char_count, :taken_by)
  end
end
