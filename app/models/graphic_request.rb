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

class GraphicRequest < ApplicationRecord
  belongs_to :user
  enum status: {요청: 0, 디자이너_설정: 1, 디자인_완료: 2, 완료: 3}

end
