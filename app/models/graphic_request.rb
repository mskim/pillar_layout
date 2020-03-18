# == Schema Information
#
# Table name: graphic_requests
#
#  id          :bigint           not null, primary key
#  column      :integer
#  data        :text
#  date        :date
#  designer    :string
#  page_column :integer
#  request     :text
#  row         :integer
#  status      :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_graphic_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class GraphicRequest < ApplicationRecord
  belongs_to :user
  enum status: {요청: 0, 디자이너_설정: 1, 디자인_완료: 2, 완료: 3}

end
