module GithubWorkingArticle
  extend ActiveSupport::Concern

  def save_for_github
    save_image_folder
    save_article
  end

  def image_folder_path
    path + "/images"
  end

  def rlayout_rb_path
    path + "/rlayout_rb"
  end

  def save_image_folder
    FileUtils.mkdir_p(image_folder_path) unless File.exist?(image_folder_path)
  end

end