# == Schema Information
#
# Table name: graphic_requests
#
#  id          :bigint(8)        not null, primary key
#  date        :date
#  user_id     :bigint(8)
#  designer    :string
#  request     :text
#  data        :text
#  status      :integer          default("요청")
#  page_column :integer
#  column      :integer
#  row         :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_graphic_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe GraphicRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
