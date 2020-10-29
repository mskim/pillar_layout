# == Schema Information
#
# Table name: qrcodes
#
#  id          :bigint           not null, primary key
#  height      :decimal(, )
#  qr_text     :string
#  qrcode_file :string
#  qrcode_type :string
#  width       :decimal(, )
#  x           :decimal(, )
#  y           :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  web_page_id :bigint           not null
#
# Indexes
#
#  index_qrcodes_on_web_page_id  (web_page_id)
#
# Foreign Keys
#
#  fk_rails_...  (web_page_id => web_pages.id)
#
require 'test_helper'

class QrcodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
