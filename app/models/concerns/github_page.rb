module GithubPage
  extend ActiveSupport::Concern

  def save_for_github
    save_config_file
    save_heading
    save_ad_folder
    save_pillars
  end

  def save_heading
    page_heading.save_for_github
  end

  def save_ad_folder
    ad_box.each do |ad|
      ad.save_for_github
    end
  end

  def save_pillars
    puts __method__
    pillars.each do |pillar|
      pillar.save_for_github
    end

  end
end