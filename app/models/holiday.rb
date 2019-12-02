# == Schema Information
#
# Table name: holidays
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Holiday < ApplicationRecord
end
