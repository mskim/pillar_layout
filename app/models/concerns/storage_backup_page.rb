# frozen_string_literal: true

module StorageBackupPage
  extend ActiveSupport::Concern

  def move_carrierwave_images_to_storage
    working_articles.each(&:move_carrierwave_images_to_storage)
    ad_boxes.each(&:move_carrierwave_images_to_storage_for_ad)
  end

  def delete_carrierwave_images
    working_articles.each(&:delete_carrierwave_images)
    ad_boxes.each(&:delete_carrierwave_images_for_ad)
  end
end
