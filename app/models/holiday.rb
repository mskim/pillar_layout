# == Schema Information
#
# Table name: holidays
#
#  id         :bigint           not null, primary key
#  date       :date
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Holiday < ApplicationRecord
end
