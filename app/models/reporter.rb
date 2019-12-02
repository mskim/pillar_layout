# == Schema Information
#
# Table name: reporters
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  email             :string
#  title             :string
#  cell              :string
#  reporter_group_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_reporters_on_reporter_group_id  (reporter_group_id)
#

class Reporter < ApplicationRecord
  belongs_to :reporter_group
end
