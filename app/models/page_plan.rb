# == Schema Information
#
# Table name: page_plans
#
#  id                   :integer          not null, primary key
#  page_number          :integer
#  section_name         :string
#  selected_template_id :integer
#  column               :integer
#  row                  :integer
#  story_count          :integer
#  profile              :string
#  ad_type              :string
#  advertiser           :string
#  color_page           :boolean
#  dirty                :boolean
#  issue_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  description          :text
#  deadline             :string
#  display_name         :string
#
# Indexes
#
#  index_page_plans_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

# PagePlan is cewate with page_number and profile
# profile is parse to fill into info

class PagePlan < ApplicationRecord
  belongs_to :issue, optional: true
  has_one :page
  has_many :article_plans
  # before_create :parse_profile
  before_create :adjust_ad_type_side
  

  def need_update?
    # check the dirty field and currnent page template id
    # we miught have a case where the use changes template back to the provious one
    # this cane we do npt need to update page
    return true unless page
    return false if page.template_id == selected_template_id
    dirty
  end

  def update_page
    page.change_template(selected_template_id) if page
  end

  def team_leader
    # puts "++++++++ section_name:#{section_name}"
    ReporterGroup.where(section: section_name).first.leader
  end

  def reporters_of_group
    group = ReporterGroup.where(section: section_name).first
    group.reporters if group
  end

  def pair_page
    page_count = issue.page_plans.count
    page_count - (page_number - 1)
  end

  def set_pair_page_color
    pair = PagePlan.find(pair_page)
    unless pair.color_page == color_page
      pair.color_page = color_page
      pair.save
    end
  end

  def set_pair_bridge_ad
    pair = PagePlan.find(pair_page)
    if pair.ad_type != ad_type || pair.advertiser != advertiser
      pair.ad_type    = ad_type
      pair.advertiser = advertiser
      pair.save
    end
  end

  private

  def parse_section_name
    if section_name =~/.+(\(.+\))/
      self.display_name = $1
      self.section_name = section_name.split("(").first
    end
  end

  def adjust_ad_type_side
    self.ad_type = self.ad_type.unicode_normalize if self.ad_type
    if self.ad_type == '9단21'
      self.ad_type = page_number.odd? ? '9단21_홀' : '9단21_짝'
    elsif ad_type == '7단15'
      self.ad_type = page_number.odd? ? '7단15_홀' : '7단15_짝'
    end
  end

  def parse_profile
    if profile && profile != ""
      puts "profile:#{profile}"
      profile_array = profile.split("_")
      ad_type = profile_array[-2]
      if ad_type == "홀" || ad_type == "짝"
        ad_type = profile_array[-3] + "_" + ad_type
      end 
      # ruby eval and YAML::load doesn't handle unicode correctly !!!
      # so  "광고없음" is converted to ["ᄀ", "ᅪ", "ᆼ", "ᄀ", "ᅩ", "ᄋ", "ᅥ", "ᆹ", "ᄋ", "ᅳ", "ᆷ"]
      # found Rails solution for this!!!!
      ad_type = ad_type.unicode_normalize
      selected_section_template = Section.where(page_number: page_number, ad_type: ad_type).first
      unless selected_section_template.class == Section
        if page_number.odd?
          selected_section_template = Section.where(page_number: 101, ad_type: ad_type).first
        else
          selected_section_template = Section.where(page_number: 100, ad_type: ad_type).first
        end
      end
      unless selected_section_template.class == Section
        selected_section_template = Section.where(page_number: page_number).first
      end
      unless selected_section_template.class == Section
        puts "No section template for profile: #{profile} found!!! !!!"
        puts "using alternative template"
        selected_section_template = Section.where(ad_type: ad_type).first
        unless selected_section_template
          if page_number == 1
            selected_section_template = Section.where(page_number:1).first
          elsif page_number.odd?
            selected_section_template = Section.where(ad_type: '광고없음', page_number: 101).first
            # selected_section_template = Section.where(page_number: 101).first
          else
            selected_section_template = Section.where(ad_type: '광고없음', page_number: 100).first
            # selected_section_template = Section.where(page_number: 101).first
          end
          unless selected_section_template.class == Section
            puts "No section template for found!!!"
            return false
          end
        end
      end
      # puts "++++++++++ page_number:#{page_number}"
      # puts "selected_section_template.ad_type:#{selected_section_template.ad_type}"
      self.selected_template_id = selected_section_template.id
      self.column               = selected_section_template.column
      self.row                  = selected_section_template.row
      self.story_count          = selected_section_template.story_count
      self.ad_type              = selected_section_template.ad_type
      if page_number == 22
        puts "page_number: #{page_number}"
        self.advertiser         = "내일신문"
      elsif page_number == 23
        self.advertiser         = "내일교육"
      else
        self.advertiser         = nil
      end

      parse_section_name
      self.dirty                = true
    else
      # puts " no profile is given, so make a default page"
      return false
    end
    true
  end
end
