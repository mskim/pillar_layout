# == Schema Information
#
# Table name: combo_ads
#
#  id         :bigint           not null, primary key
#  base_ad    :string
#  column     :integer
#  layout     :text
#  profile    :string
#  row        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ComboAd, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
