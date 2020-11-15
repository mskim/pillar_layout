# frozen_string_literal: true

class IssuesController < ApplicationController
  before_action :set_issue, only: %i[show clone_pages edit update current_plan images upload_images ad_boxes ad_images upload_ad_images destroy slide_show assign_reporter send_xml_to_ebiz merge_container_xml print_status change_current all_save]
  before_action :authenticate_user!
  # TODO I added this after getting  'ActionController::InvalidAuthenticityToken' error
  skip_before_action :verify_authenticity_token

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.page(params[:page])
    @issues_for_search = Issue.page(params[:page]).reverse_order.per(8)
    session[:current_issue] = @issue
    # @issues = Issue.order(:id, 'DESC').page(params[:page]).per(20)
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    session[:current_issue] = @issue
    @pages = @issue.pages.order(:id, 'desc')
    @pages = @issue.pages
    respond_to do |format|
      format.html
      format.json { render @issue }
    end
  end

  # GET /issues/new
  def new
    @issue            = Issue.new
    @publication      = Publication.first
    @previous_date    = Issue.last.date.to_s        if Issue.last
    @previous_number  = Issue.last.number.to_i      if Issue.last
    @new_issue_number = Issue.last.number.to_i + 1  if Issue.last
  end

  # GET /issues/1/edit
  def edit; end

  # POST /issues
  # POST /issues.jsonfredirect_to
  def create
    binding.pry
    @issue = Issue.new(issue_params)
    respond_to do |format|
      if @issue.save
        @issue.make_default_issue_plan
        @issue.make_pages
        format.html { redirect_to @issue }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_plan
    issue = Issue.last
    issue.update_plan
    redirect_to issue_path(issue)
  end

  def current_plan
    session[:current_issue] = @issue
    half = @issue.page_plans.count / 2
    @front_page_plans = @issue.page_plans.select { |x| x.page_number <= half }.sort_by(&:page_number)
    @back_page_plans  = @issue.page_plans.select { |x| x.page_number > half }.sort_by(&:page_number).reverse
    @available_ads_for_pages = @issue.available_ads_for_pages
  end

  def print_status
    @pages = @issue.pages
  end

  def images
    @issue_images = @issue.images
  end

  def upload_images
    respond_to do |format|
      format.html do
        if @issue.update(issue_params)
          params[:images]['image'].each do |a|
            @image = @issue.images.create!(image: a, issue_id: @issue.id)
          end
        end
      end
    end
    redirect_to images_issue_path(@issue.id)
    # images_issue_path(Issue.last.id)
  end

  def ad_boxes
    @issue_plans_with_ad  = @issue.page_plan_with_ad
    @issue_ad_boxes       = @issue.ad_boxes
  end

  def ad_images
    @issue_plans_with_ad  = @issue.page_plan_with_ad
    @issue_ad_images      = @issue.ad_images
  end

  def upload_ad_images
    respond_to do |format|
      format.html do
        if @issue.update(issue_params)
          params[:ad_images]['ad_image'].each do |a|
            @ad = @issue.ad_images.create!(ad_image: a, issue_id: @issue.id)
          end
        end
      end
    end
    redirect_to ad_images_issue_path(@issue.id)
    # images_issue_path(Issue.last.id)
  end

  def demo
    # code
  end

  def change_current
    redirect_to issue_path
  end

  def first_group
    set_issue
    group = @issue.publication.sections[0]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'first_group'
  end

  def second_group
    set_issue
    group = @issue.publication.sections[1]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'second_group'
  end

  def third_group
    set_issue
    group = @issue.publication.sections[2]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'third_group'
  end

  def fourth_group
    set_issue
    group = @issue.publication.sections[3]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'fourth_group'
  end

  def fifth_group
    set_issue
    group = @issue.publication.sections[4]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'fifth_group'
  end

  def sixth_group
    set_issue
    group = @issue.publication.sections[5]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'sixth_group'
  end

  def seventh_group
    set_issue
    group = @issue.publication.sections[6]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'seventh_group'
  end

  def eighth_group
    set_issue
    group = @issue.publication.sections[7]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'eighth_group'
  end

  # 오피니언
  def nineth_group
    set_issue
    group = @issue.publication.sections[8]
    @pages = @issue.pages.select { |p| p.section_name == group }
    session[:current_group] = 'nineth_group'
  end

  def ad_group
    set_issue
    session[:current_group] = 'ad_group'
    @pages = @issue.pages.select { |p| p.section_name == '전면광고' }
  end

  def spread
    set_issue
    # @spread = @issue.spread
    @page = @issue.pages[24]
  end

  def clone_pages
    @clone_pages = Page.clone_pages
  end

  def slide_show; end

  def assign_reporter
    @reporters        = User.reject { |u| u.group.nil? }.sort_by(&:group)
    @working_articles = []
    @issue.pages.each do |page|
      @working_articles += page.working_articles.sort_by(&:pillar_order)
      # @working_articles += page.working_articles(&:order)
    end # code
  end

  def generate_stories
    Story.start_story
    redirect_to stories_path
  end

  def first_group_stories
    set_issue
    group = @issue.publication.sections[0]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'first_group'
  end

  def second_group_stories
    set_issue
    group = @issue.publication.sections[1]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'second_group'
  end

  def third_group_stories
    set_issue
    group = @issue.publication.sections[2]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'third_group'
  end

  def fourth_group_stories
    set_issue
    group = @issue.publication.sections[3]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'fourth_group'
  end

  def fifth_group_stories
    set_issue
    group = @issue.publication.sections[4]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'fifth_group'
  end

  def sixth_group_stories
    set_issue
    group = @issue.publication.sections[5]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'sixth_group'
  end

  def seventh_group_stories
    set_issue
    group = @issue.publication.sections[6]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'seventh_group'
  end

  def eighth_group_stories
    set_issue
    group = @issue.publication.sections[7]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'eighth_group'
  end

  def nineth_group_stories
    set_issue
    group = @issue.publication.sections[8]
    @pages = @issue.pages.select { |p| p.section_name == group }
    @stories = Story.where(summitted_section: group)
    session[:current_story_group] = 'nineth_group'
  end

  def download_website
    set_issue
    @issue.build_website unless File.exist?(@issue.static_zip_path)
    send_file(@issue.static_zip_path, type: 'application/zip', x_sendfile: true, disposition: 'attachment')
  end

  def build_website
    set_issue
    @issue.build_website
    redirect_to @issue
    # redirect_to issue_path(@issue, notice: 'html 파일이 생성 되었습니다.')
  end

  def save_story_xml
    set_issue
    if File.exist?(@issue.xml_zip_path)
      system("rm #{@issue.xml_zip_path}")
      @issue.save_story_xml
      redirect_to issue_path(@issue), notice: 'xml 파일이 재생성 되었습니다.'
    else
      @issue.save_story_xml
      redirect_to issue_path(@issue), notice: 'xml 파일이 생성 되었습니다.'
    end
  end

  def save_preview_xml
    set_issue
    if File.exist?(@issue.preview_xml_zip_path)
      system("rm #{@issue.preview_xml_zip_path}")
      @issue.save_preview_xml
      redirect_to issue_path(@issue), notice: '지면보기용 xml 파일이 재생성 되었습니다.'
    else
      @issue.save_preview_xml
      redirect_to issue_path(@issue), notice: '지면보기용 xml 파일이 생성 되었습니다.'
    end
  end

  def download_story_xml
    set_issue
    # send_file @issue.xml_zip_path, type: 'application/zip'
    respond_to do |format|
      format.zip { send_data File.open(@issue.xml_zip_path, 'r', &:read) }
      # zip: {send_data File.open(@issue.xml_zip_path, 'r'){|f| f.read} }
    end
    # send_file @issue.xml_zip_path, :type=>'application/zip', :x_sendfile=>true, :disposition => "attachment", :filename =>filename
    # send_file @issue.xml_zip_path, :type=>'application/zip', :disposition => "attachment", :filename =>filename
    # redirect_to issue_path(@issue), notice: 'xml 다운로드 되었습니다.'
  end

  def send_xml_to_ebiz
    result = @issue.copy_to_xml_ftp
    if result
      redirect_to @issue, notice: '뉴스와 지면보기용 xml 파일이 전송 되었습니다.'
    else
      redirect_to @issue, notice: result.to_s
    end
  end

  def save_mobile_preview_xml
    set_issue
    # if File.exist?(@issue.mobile_preview_xml_zip_path)
    #   system("rm #{@issue.mobile_preview_xml_zip_path}")
    @issue.save_mobile_preview_xml
    redirect_to issue_path(@issue), notice: '모바일용 지면보기 xml 파일이 재생성 되었습니다.'
    # else
    #   @issue.save_mobile_preview_xml
    #   redirect_to issue_path(@issue), notice: '모바일용 지면보기 xml 파일이 생성 되었습니다.'
    # end
  end

  def download_preview_xml
    set_issue
    respond_to do |format|
      format.zip { send_data File.open(@issue.preview_xml_zip_path, 'r', &:read) }
      # zip: {send_data File.open(@issue.xml_zip_path, 'r'){|f| f.read} }
    end
  end

  def merge_container_xml
    # def send_mobile_preview_xml
    set_issue
    XmlWorker.perform_async(@issue.id)
    # @issue.send_mobile_preview_xml
    redirect_to issue_path(@issue), notice: '모바일용 지면보기 xml 파일이 합성 되었습니다.'
  end

  def build_website
    set_issue
    @issue.build_website
    redirect_to(@issue)
  end

  def edit_static_pages
    set_issue
    @issue = Issue.find(params[:id])
    @stories = Story.where(selected_for_web: true, date: @issue.date).or(Story.where(story_type: '웹용', date: @issue.date))
    respond_to do |format|
      format.json { render json: @stories }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = if params[:id]
               # @issue = Issue.find(params[:id])
               # @issue = Issue.friendly.find(params[:id])
               Issue.find(params[:id])

             else
               Issue.last
             end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    # params.require(:issue).permit(:date, :number, :plan, :publication_id, images_attributes: [:id, :issue_id, :image])
    params.require(:issue).permit(:date, :number, :plan, :publication_id, :excel_file, images_attributes: %i[id issue_id image])
  end
end
