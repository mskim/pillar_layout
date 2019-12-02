class ArticlePlansController < ApplicationController
  before_action :set_article_plan, only: [:show, :edit, :update, :destroy]

  # GET /article_plans
  # GET /article_plans.json
  def index
    @article_plans = ArticlePlan.all
  end

  # GET /article_plans/1
  # GET /article_plans/1.json
  def show
  end

  # GET /article_plans/new
  def new
    @article_plan = ArticlePlan.new
  end

  # GET /article_plans/1/edit
  def edit
    @reporters = @article_plan.reporters_of_group
  end

  # POST /article_plans
  # POST /article_plans.json
  def create
    @article_plan = ArticlePlan.new(article_plan_params)

    respond_to do |format|
      if @article_plan.save
        format.html { redirect_to @article_plan, notice: 'Article plan was successfully created.' }
        format.json { render :show, status: :created, location: @article_plan }
      else
        format.html { render :new }
        format.json { render json: @article_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_plans/1
  # PATCH/PUT /article_plans/1.json
  def update
    respond_to do |format|
      if @article_plan.update(article_plan_params)
        format.html { redirect_to page_plan_path(@article_plan.page_plan), notice: '기사 배정이 수정 되었습니다.' }
        format.json { render :show, status: :ok, location: @article_plan }
      else
        format.html { render :edit }
        format.json { render json: @article_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_plans/1
  # DELETE /article_plans/1.json
  def destroy
    @article_plan.destroy
    respond_to do |format|
      format.html { redirect_to article_plans_url, notice: 'Article plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_plan
      @article_plan = ArticlePlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_plan_params
      params.require(:article_plan).permit(:page_plan_id, :reporter, :order, :title)
    end
end
