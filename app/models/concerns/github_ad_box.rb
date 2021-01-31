module GithubAdBox
  extend ActiveSupport::Concern

  def save_for_github
    save_layout_with_local_image
  end

  def save_layout_with_local_image
    puts __method__
  end

  def images_folder
    path + "/images"
  end

  def copy_image
    FileUtils.mkdir_p(images_folder) unless File.exist?(images_folder)
    # create images folder
    # copy image from active_storage to local folder
  end
end