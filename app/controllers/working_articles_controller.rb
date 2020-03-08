# frozen_string_literal: true

class WorkingArticlesController < ApplicationController
  before_action :set_working_article, only: %i[show edit update destroy download_pdf upload_images upload_graphics zoom_preview change_story update_story assign_reporter add_image]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  layout 'working_article'
  # GET /working_articles
  # GET /working_articles.json
  def index
    # rails controller 에서
    # ruby
    @q = WorkingArticle.ransack(params[:q])
    @working_articles = @q.result
    # @pages = Page.all.includes(:issue)
    # @working_articles = WorkingArticle.all
  end

  # GET /working_articles/1
  # GET /working_articles/1.json
  def show
    # Group_Image new
    @group_image = GroupImage.new
    # Group_Image all
    @group_images = GroupImage.all
    @pages = @working_article.issue.pages.order(:id, 'desc')
    section_name = @working_article.page.section_name
    @pages = @working_article.issue.pages.select { |p| p.section_name == section_name }
    # @reporter_images = ReporterImage.where(section_name:section_name, updated_at: @working_article.issue.updated_at).all
    # @reporter_graphics = ReporterGraphic.where(section_name:section_name, updated_at: @working_article.issue.updated_at).all
    session[:current_story_group] = @working_article.group_name
    @reporter_images = ReporterImage.where(section_name: section_name).all
    @reporter_graphics = ReporterGraphic.where(section_name: section_name).all
    respond_to do |format|
      format.html
      format.json { render @working_article }
    end
    change_story
  end

  # GET /working_articles/new
  def new
    @working_article = WorkingArticle.new
  end

  # GET /working_articles/1/edit
  def edit
    # puts "in edit of working_article"
    # puts "@working_article.issue.date:#{@working_article.issue.date}"
    # puts "@working_article.page.section_name:#{@working_article.page.section_name}"
    # @stories = Story.where(date:@working_article.date, group: @working_article.page.section_name)
    @stories = Story.where(group: @working_article.page.section_name)
  end

  # POST /working_articles
  # POST /working_articles.json
  def create
    @working_article = WorkingArticle.new(working_article_params)

    respond_to do |format|
      if @working_article.save
        format.html { redirect_to @working_article, notice: 'Working article was successfully created.' }
        format.json { render :show, status: :created, location: @working_article }
      else
        format.html { render :new }
        format.json { render json: @working_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /working_articles/1
  # PATCH/PUT /working_articles/1.json
  def update
    respond_to do |format|
      params['working_article']['subject_head'] = @working_article.filter_to_title(params['working_article']['subject_head'])
      params['working_article']['subject_head'] = @working_article.filter_to_quote(params['working_article']['subject_head'])
      params['working_article']['title'] = @working_article.filter_to_title(params['working_article']['title'])
      params['working_article']['title'] = @working_article.filter_to_quote(params['working_article']['title'])
      params['working_article']['subtitle'] = @working_article.filter_to_title(params['working_article']['subtitle'])
      params['working_article']['subtitle'] = @working_article.filter_to_quote(params['working_article']['subtitle'])
      params['working_article']['body'] = @working_article.filter_to_markdown(params['working_article']['body'])
      params['working_article']['body'] = @working_article.filter_to_quote(params['working_article']['body'])
      if @working_article.update(working_article_params)
        # if @working_article.draft_mode
        #   h = {}
        #   h[:draft_mode]    = true
        #   h[:story_md]      = @working_article.story_md
        #   h[:article_path]  = @working_article.path
        #   RLayout::NewsBoxMaker.new(h)
        #   # send_data pdf.render, filename: "#{@working_article.id}", type: "application/pdf", disposition: "inline"
        # else
        @working_article.generate_pdf_with_time_stamp
        @working_article.page.generate_pdf_with_time_stamp
        # end

        if story = @working_article.story
          story_h = {}
          story_h[:subject_head] = params['working_article']['subject_head'] = @working_article.filter_to_title(params['working_article']['subject_head'])
          story_h[:subject_head] = params['working_article']['subject_head'] = @working_article.filter_to_quote(params['working_article']['subject_head'])
          story_h[:title] = params['working_article']['title'] = @working_article.filter_to_title(params['working_article']['title'])
          story_h[:title] = params['working_article']['title'] = @working_article.filter_to_quote(params['working_article']['title'])
          story_h[:subtitle] = params['working_article']['subtitle'] = @working_article.filter_to_title(params['working_article']['subtitle'])
          story_h[:subtitle] = params['working_article']['subtitle'] = @working_article.filter_to_quote(params['working_article']['subtitle'])
          story_h[:body] = params['working_article']['body'] = @working_article.filter_to_markdown(params['working_article']['body'])
          story_h[:body] = params['working_article']['body'] = @working_article.filter_to_quote(params['working_article']['body'])
          story_h[:body] = params['working_article']['by_line'] = params['working_article']['by_line']
          story_h[:body] = params['working_article']['category'] = params['working_article']['category']
          story_h[:body] = params['working_article']['price'] = params['working_article']['price']
          story.update(story_h)
        end
        # format.html { render @working_article, notice: 'Working article was successfully updated.' }
        format.html { redirect_to @working_article, notice: 'Working article was successfully updated.' }
        format.js { render js: "window.location = '#{working_article_path(@working_article)}'" }
        format.json { render :show, status: :ok, location: @working_article }

      else
        format.html { render :edit }
        format.json { render json: @working_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /working_articles/1
  # DELETE /working_articles/1.json
  def destroy
    @working_article.destroy
    respond_to do |format|
      format.html { redirect_to working_articles_url, notice: 'Working article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_reporter
    # @working_article.update(working_article_params)

    respond_to do |format|
      if @working_article.update(working_article_params)

        # format.html { rendrer @working_article, notice: 'Working article was successfully updated.' }
        # format.html { redirect_to @working_article, notice: 'Working article was successfully updated.' }
        format.js { render js: "window.location = '#{working_article_path(@working_article)}'" }
        format.json { render :show, status: :ok, location: @working_article }
      else
        format.html { render :edit }
        format.json { render json: @working_article.errors, status: :unprocessable_entity }
      end
    end
    # redirect_to assign_reporter_issue_path(Issue.last)
  end

  def change_story
    # todo
    # @stories = Story.where(group: , date: date) name: :desc
    # @stories = Story.where(summitted_section: @working_article.page.section_name).order(selected: 'desc')
    @stories = Story.where('updated_at' => (DateTime.now.at_beginning_of_day.utc..Time.now.utc), summitted_section: @working_article.page.section_name).order(:updated_at).reverse
    assigned = @stories.select { |s| s.working_article_id == @working_article.id }
    @stories = assigned unless assigned.empty?
    # TODO
    # if story is assigned, to current_article, no need to display other stories
  end

  def update_story
    story_id = params[:story_id]
    # update working_article with new story
    case session[:current_story_group]
    when 'first_group'
      redirect_to first_group_stories_issue_path(@working_article.issue)
    when 'second_group'
      redirect_to second_group_stories_issue_path(@working_article.issue)
    when 'third_group'
      redirect_to third_group_stories_issue_path(@working_article.issue)
    when 'fourth_group'
      redirect_to fourth_group_stories_issue_path(@working_article.issue)
    when 'fifth_group'
      redirect_to fifth_group_stories_issue_path(@working_article.issue)
    when 'sixth_group'
      redirect_to sixth_group_stories_issue_path(@working_article.issue)
    when 'seventh_group'
      redirect_to seventh_group_stories_issue_path(@working_article.issue)
    when 'seventh_group'
      redirect_to seventh_group_stories_issue_path(@working_article.issue)
    when 'eighth_group'
      redirect_to eighth_group_stories_issue_path(@working_article.issue)
    when 'nineth_group'
      redirect_to nineth_group_stories_issue_path(@working_article.issue)
    else
      # redirect_to first_group_stories_issue_path(Issue.last)
      redirect_to eighth_group_stories_issue_path(Issue.last)
    end
  end

  # download story.pdf
  def download_pdf
    send_file @working_article.pdf_path, type: 'application/pdf', x_sendfile: true, disposition: 'attachment'
  end

  def image_1x1
    set_working_article
    image = @working_article.images.first
    need_pdf_update = if image
                        image.change_size('1x1')
                      else
                        @working_article.create_image_place_holder(1, 1)
                      end
    @working_article.generate_pdf_with_time_stamp if need_pdf_update
    redirect_to @working_article
  end

  def image_2x2
    set_working_article
    image = @working_article.images.first
    need_pdf_update = if image
                        image.change_size('2x2')
                      else
                        @working_article.create_image_place_holder(2, 2)
                      end
    @working_article.generate_pdf_with_time_stamp if need_pdf_update
    redirect_to @working_article
  end

  def image_3x3
    set_working_article
    image = @working_article.images.first
    need_pdf_update = if image
                        image.change_size('3x3')
                      else
                        @working_article.create_image_place_holder(3, 3)
                      end
    @working_article.generate_pdf_with_time_stamp if need_pdf_update
    redirect_to @working_article
  end

  def image_4x4
    set_working_article
    image = @working_article.images.first
    need_pdf_update = if image
                        image.change_size('4x4')
                      else
                        @working_article.create_image_place_holder(4, 4)
                      end
    @working_article.generate_pdf_with_time_stamp if need_pdf_update
    redirect_to @working_article
  end

  def image_5x5
    set_working_article
    image = @working_article.images.first
    need_pdf_update = if image
                        image.change_size('5x5')
                      else
                        @working_article.create_image_place_holder(5, 5)
                      end
    @working_article.generate_pdf_with_time_stamp if need_pdf_update
    redirect_to @working_article
  end

  def image_auto
    set_working_article
    image = @working_article.images.first
    image.change_size('auto')
    redirect_to @working_article
  end

  def add_image
    @library_images = @working_article.library_images
    @current_image  = images.first
  end

  def select_image
    images.first
    @selected_image = params[:selected_image]
  end

  def add_personal_image
    # code
  end

  def add_empty_image; end

  def upload_images
    respond_to do |format|
      format.html do
        if params['working_article']['storage_image']
          Array(params['working_article']['storage_image']).each do |a|
            @image = @working_article.images.create!(storage_image: a, working_article_id: @working_article.id)
          end
        else
          @image = @working_article.images.create!(working_article_id: @working_article.id)
        end
      end
    end
    @image.working_article.generate_pdf_with_time_stamp
    @image.working_article.page.generate_pdf_with_time_stamp
    redirect_to @working_article
    # images_issue_path(Issue.last.id)
  end

  def upload_graphics
    respond_to do |format|
      format.html do
        params[:images]['image'].each do |a|
          @graphic = @working_article.graphics.create!(storage_graphic: a, working_article_id: @working_article.id)
        end
      end
    end

    @graphic.working_article.generate_pdf_with_time_stamp
    @graphic.working_article.page.generate_pdf_with_time_stamp
    redirect_to @working_article
  end

  def zoom_preview
    # code
  end

  # auto adjust article height
  def auto_adjust_height
    set_working_article
    @working_article.auto_adjust_height
    redirect_to @working_article
  end

  # auto adjust article height for all articlds in same pillar
  def auto_adjust_height_all
    set_working_article
    @working_article.auto_adjust_height_all
    redirect_to @working_article
  end

  def extend_zero
    set_working_article
    @working_article.set_extend_line(0)
    redirect_to working_article_path(@working_article), notice: '박스크기 추가가 0행으로 설정 되었습니다.'
  end

  def extend_one
    set_working_article
    @working_article.extend_line(1)
    redirect_to working_article_path(@working_article), notice: '박스크기 1 행 추가 되었습니다.'
  end

  def extend_two
    set_working_article
    @working_article.extend_line(2)
    redirect_to working_article_path(@working_article), notice: '박스크기 2 행 추가 되었습니다.'
  end

  def extend_three
    set_working_article
    @working_article.extend_line(3)
    redirect_to working_article_path(@working_article), notice: '박스크기 3 행 추가 되었습니다.'
  end

  def extend_four
    set_working_article
    @working_article.extend_line(4)
    redirect_to working_article_path(@working_article), notice: '박스크기 4 행 추가 되었습니다.'
  end

  def reduce_one
    set_working_article
    @working_article.extend_line(-1)
    redirect_to working_article_path(@working_article), notice: '박스크기 -1 행 축소 되었습니다.'
  end

  def reduce_two
    set_working_article
    @working_article.extend_line(-2)
    redirect_to working_article_path(@working_article), notice: '박스크기 -2 행 축소 되었습니다.'
  end

  def reduce_three
    set_working_article
    @working_article.extend_line(-3)
    redirect_to working_article_path(@working_article), notice: '박스크기 -3 행 축소 되었습니다.'
  end

  def reduce_four
    set_working_article
    @working_article.extend_line(-4)
    redirect_to working_article_path(@working_article), notice: '박스크기 -4 행 축소 되었습니다.'
  end

  def swap
    set_working_article
    @working_article.swap
    redirect_to working_article_path(@working_article), notice: '위 아래 기사가 교체 되었습니다.'
  end

  def show_quote_box
    set_working_article
    @working_article.show_quote_box('일반')
    redirect_to working_article_path(@working_article), notice: '발문 박스 추가.'
  end

  def show_quote_box_for_opinion2
    set_working_article
    @working_article.show_quote_box('기고2행')
    redirect_to working_article_path(@working_article), notice: '2행 발문 박스 추가.'
  end

  def show_quote_box_for_opinion3
    set_working_article
    @working_article.show_quote_box('기고3행')
    redirect_to working_article_path(@working_article), notice: '3행 발문 박스 추가.'
  end

  def hide_quote_box
    set_working_article
    @working_article.hide_quote_box
    redirect_to working_article_path(@working_article), notice: '발문 박스가 삭제 되었습니다.'
  end

  def boxed_subtitle_one
    set_working_article
    @working_article.boxed_subtitle_one
    redirect_to working_article_path(@working_article), notice: '본문 박스부제가(회색_고딕)가 생성 되었습니다.'
  end

  def boxed_subtitle_two
    set_working_article
    @working_article.boxed_subtitle_two
    redirect_to working_article_path(@working_article), notice: '본문 박스부제가(테두리)가 생성 되었습니다.'
  end

  def boxed_subtitle_zero
    set_working_article
    @working_article.boxed_subtitle_zero
    redirect_to working_article_path(@working_article), notice: '본문 박스부제가 삭제 되었습니다.'
  end

  def announcement_zero
    set_working_article
    @working_article.announcement_zero
    redirect_to working_article_path(@working_article), notice: '안내문이 삭제 되었습니다.'
  end

  def announcement_one
    set_working_article
    @working_article.announcement_one
    redirect_to working_article_path(@working_article), notice: '1단(내일 쉽니다.) 안내문이 생성 되었습니다.'
  end

  def announcement_two
    set_working_article
    @working_article.announcement_two
    redirect_to working_article_path(@working_article), notice: '2단(다음면으로...) 안내문이 생성 되었습니다.'
  end

  def split_article(options)
    @working_article.split(options)
  end

  def split_article_vertically(_options)
    split_article(direction: 'v')
  end

  def split_article_horinotally(_options)
    split_article(direction: 'h')
  end

  def select_reporter_graphic
    set_working_article
    reporter_graphic = ReporterGraphic.find(params[:reporter_graphic])
    # TODO
    # g = Graphic.create(working_article_id:@working_article.id, reporter_graphic_path:reporter_graphic.full_size_path)
    g = Graphic.create(working_article_id: @working_article.id, reporter_graphic_path: reporter_graphic.preview_path)
    @working_article.generate_pdf_with_time_stamp
    redirect_to @working_article
  end

  def select_reporter_image
    set_working_article
    reporter_image = ReporterImage.find(params[:reporter_image])

    # 지면으로 출고된 나의 사진을 선택하면 today_issue/images 로 사진 복사
    filename = "#{@working_article.page_number}_#{@working_article.order}_#{@working_article.images.count}.jpg"
    source = "#{Rails.root}/public/#{reporter_image.full_size_path}"
    target = "#{@working_article.issue.issue_images_path}/#{filename}"
    layout_target = "#{@working_article.image_path}/#{filename}"
    puts "select_reporter_image: #{target}"
    system("cp #{source} #{target}")
    # TODO
    # i = Image.create!(working_article_id:@working_article.id, reporter_image_path:reporter_image.full_size_path)
    i = Image.create!(working_article_id: @working_article.id, reporter_image_path: layout_target)
    i.caption_title = reporter_image.title
    i.caption = reporter_image.caption
    i.save
    @working_article.generate_pdf_with_time_stamp
    @working_article.update_page_pdf_with_time_stamp
    redirect_to @working_article
  end

  def autofit_by_height
    set_working_article
    @working_article.autofit_by_height
    redirect_to @working_article
  end

  def autofit_by_height_plus
    set_working_article
    @working_article.autofit_by_height(enough_space: true)
    redirect_to @working_article
  end

  def autofit_by_image_size
    set_working_article
    @working_article.autofit_by_image_size
    redirect_to @working_article
  end

  def autofit_with_sibllings
    set_working_article
    @working_article.autofit_with_sibllings
    redirect_to @working_article
  end

  def autofit_with_sibllings_plus
    set_working_article
    @working_article.autofit_with_sibllings(enough_space: true)
    redirect_to @working_article
  end

  def create_new_proof
    proof_image_url = @working_article.create_proof_image
    Proof.create(working_article_id: @working_article.id, image_url: proof_image_url)
    redirect_to @working_article
  end

  def v_cut_minus_one
    set_working_article
    v_cut_at(@working_article, -1)
    redirect_to @working_article
  end

  def v_cut_minus_two
    set_working_article
    v_cut_at(@working_article, -2)
    redirect_to @working_article
  end

  def v_cut_minus_three
    set_working_article
    v_cut_at(@working_article, -3)
    redirect_to @working_article
  end

  def v_cut_at(w, cut_index)
    w.v_cut_at(cut_index)
  end

  def h_cut
    set_working_article
    @working_article.h_cut
    redirect_to @working_article
    redirect_to @working_article

  end

  def create_overlap
    set_working_article
    @working_article.create_overlap
    redirect_to @working_article

  end

  def delete_overlap
    set_working_article
    @working_article.delete_overlap
    redirect_to @working_article
  end

  def clear_crop_rect
    set_working_article
    image = Image.find(params['image_id'])
    image_has_crop_rect = image.has_crop_rect?
    image.clear_crop_rect
    @working_article.generate_pdf_with_time_stamp if image_has_crop_rect
    redirect_to @working_article
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_working_article
    # @working_article = WorkingArticle.find(params[:id])
    @working_article = WorkingArticle.includes(:page).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def working_article_params
    params.require(:working_article).permit(:column, :row, :order, :profile, :kind, :subject_head, :title, :heading_columns, :title_head, :subtitle, :subtitle_type, :subtitle_head, :body, :reporter, :email, :has_profile_image, :image, :quote, :is_front_page, :top_story, :top_position, :page_id, :boxed_subtitle_type, :boxed_subtitle_text, :announcement_text, :announcement_color, :quote_position, :quote_x_grid, :quote_v_extra_space, :quote_alignment, :quote_line_type, :quote_box_column, :quote_box_show, :category_code, :price, :subcategory_code, :image_id)
  end

  def filter_markdown?
    params[:commit] == '본문정리'
  end
end
