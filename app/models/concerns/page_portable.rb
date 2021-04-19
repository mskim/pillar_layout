
# We want import/export pages into issue
# This will make a make as a portable
# Save it as and edit it perhaps offline with  ruby gem installed enviroment.

module PagePortable
  extend ActiveSupport::Concern

  def archive_path
    "#{Rails.root}/1/portable_page"
  end

  # save current_page to archive
  def archive_page(profile)
    path = portable_page + "/#{profile}.p_page"

  end

  # load archived page to current page
  def load_portable_page(path)

  end
end