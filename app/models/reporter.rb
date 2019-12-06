# == Schema Information
#
# Table name: reporters
#
#  id                :bigint           not null, primary key
#  cell              :string
#  email             :string
#  name              :string
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reporter_group_id :bigint
#
# Indexes
#
#  index_reporters_on_reporter_group_id  (reporter_group_id)
#

class Reporter < ApplicationRecord
  belongs_to :reporter_group
end
