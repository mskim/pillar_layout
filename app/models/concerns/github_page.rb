module GithubPage
  extend ActiveSupport::Concern

  def save_for_github
    save_heading
    save_ad_folder
    save_pillars
  end

  def save_heading
    puts __method__
  end

  def save_ad_folder
    puts __method__

  end

  def save_pillars
    puts __method__

  end
end