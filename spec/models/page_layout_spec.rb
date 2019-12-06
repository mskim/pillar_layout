# == Schema Information
#
# Table name: page_layouts
#
#  id                      :bigint           not null, primary key
#  ad_type                 :string
#  column                  :integer
#  doc_height              :float
#  doc_width               :float
#  grid_height             :float
#  grid_width              :float
#  gutter                  :float
#  layout                  :text
#  layout_with_pillar_path :text
#  like                    :integer
#  margin                  :float
#  page_type               :integer
#  pillar_count            :integer
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe PageLayout, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
