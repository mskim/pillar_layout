# == Schema Information
#
# Table name: reporter_groups
#
#  id            :bigint           not null, primary key
#  category_code :integer
#  leader        :string
#  page_range    :string
#  section       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ReporterGroup < ApplicationRecord
  has_many :reporters
end
