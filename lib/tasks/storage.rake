# frozen_string_literal: true

namespace :storage do
  desc '기존 carrierwave에서 저장된 이미지들을 active_storage로 옮깁니다'
  task move_carrierwave_images_to_storage: :environment do
    Page.all.each(&:move_carrierwave_images_to_storage)
  end

  desc '기존 carrierwave에서 저장된 이미지들을 삭제'
  task move_carrierwave_images_to_storage: :environment do
    Page.all.each(&:delete_carrierwave_images)
  end
end
