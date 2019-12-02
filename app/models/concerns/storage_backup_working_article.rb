# frozen_string_literal: true

module StorageBackupWorkingArticle
  extend ActiveSupport::Concern

  def move_carrierwave_images_to_storage
    images.each do |image|
      # 이미 옮긴 이미지 일경우 하지 말것 마치, first_or_create처럼
      unless image.storage_image.attach?
        filename = File.basename(URI.parse(image.image.url))
        image.storage_image.attach(io: open(image.image.url), filename: d.file)
      end
    rescue StandardError => e
      ## log/handle your errors in order to retry later
    end
    graphics.each do |graphic|
      unless graphic.storage_graphic.attach?
        filename = File.basename(URI.parse(graphic.graphic.url))
        graphic.storage_graphic.attach(io: open(graphic.graphic.url), filename: d.file)
      end
    rescue StandardError => e
      ## log/handle your errors in order to retry later
    end
  end

  def carrierwave_image_full_path
    "#{Rails.root}/public/image.url"
  end

  def delete_carrierwave_images; end

  # for ad_box
  def move_carrierwave_images_to_storage_for_ad
    # 이거는 기존 carrierwave 에서 가저 오는거니까
    #
    unless ad_image.storage_ad_image.attach?
      if ad_image.present?
        filename = File.basename(URI.parse(ad_image.url))
        storage_ad_image.attach(io: open(ad_image.url), filename: d.file)
      end
    end
    # rescue StandardError => e
    #   ## log/handle your errors in order to retry later
    # end
  end

  def delete_carrierwave_images_for_ad; end
end
