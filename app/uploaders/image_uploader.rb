class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # image_count is currnet image count, it becomes last part of next image's file_name
  # page_number_article_number_image_count.extension
  def filename
    "#{model.page_number}_#{model.article_order}_#{model.image_count}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "#{model.publication.id}/issue/#{model.issue.date}/images"
  end

  # version :thumb do
  #   process resize_to_fill: [200,200]
  # end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :large do
  #   process resize_to_fit: [600, 400]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png pdf eps)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # version :thumb do
  #   process :crop
  #   resize_to_fill(100, 100)
  # end

  # version :tiny, from_version: :thumb do
  #   process resize_to_fill: [20, 20]
  # end

  # version :large do
  #   resize_to_limit(600, 600)
  # end

  # def crop
  #   if model.crop_x.present?
  #     resize_to_limit(600, 600)
  #     manipulate! do |img|
  #       x = model.crop_x.to_i
  #       y = model.crop_y.to_i
  #       w = model.crop_w.to_i
  #       h = model.crop_h.to_i
  #       # [[w, h].join('x'),[x, y].join('+')].join('+') => "wxh+x+y"
  #       img.crop([[w, h].join('x'),[x, y].join('+')].join('+'))
  #     end
  #   end
  # end

end
