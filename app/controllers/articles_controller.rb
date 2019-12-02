class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :download_pdf, :fill, :add_image, :select_image, :add_personal_image, :add_quote]
  before_action :authenticate_user!

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        @article.generate_pdf
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def one
    @articles = Article.one_column
  end

  def two
    @articles = Article.two_column
  end

  def three
    @articles = Article.three_column
  end

  def four
    @articles = Article.four_column
  end

  def five
    @articles = Article.five_column
  end

  def six
    @articles = Article.six_column
  end

  def seven
    @articles = Article.seven_column
  end

  # download story.pdf
  def download_pdf
    send_file @article.pdf_path, :type=>'application/pdf', :x_sendfile=>true, :disposition => "attachment"
  end

  def style_update
    #code
  end

  def fill
    @article.fill_up_enpty_lines
    redirect_to @article, notice: 'Article was successfully created.'
    #code
  end

  def send_email
    #code
  end

  def add_image
    @library_images = @article.library_images
  end

  def select_image
    # puts "params:#{params}"
    # puts "params.inspect:#{params.inspect}"

    @selected_image = params[:selected_image]
  end

  def add_personal_image
    #code
  end

  def add_quote
    #code
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:column, :row, :title, :subtitle, :body, :reporter, :has_profile_image, :image, :quote, :publication_id)
    end
end
