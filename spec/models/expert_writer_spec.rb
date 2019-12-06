# == Schema Information
#
# Table name: expert_writers
#
#  id               :bigint           not null, primary key
#  category_code    :string
#  email            :string
#  expert_image     :string
#  expert_jpg_image :string
#  name             :string
#  position         :string
#  work             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ExpertWriter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
