# == Schema Information
#
# Table name: actions
#
#  id         :bigint           not null, primary key
#  actions    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
