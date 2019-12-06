# == Schema Information
#
# Table name: announcements
#
#  id             :bigint           not null, primary key
#  color          :string
#  column         :integer
#  kind           :string
#  lines          :integer
#  name           :string
#  page           :integer
#  page_column    :integer
#  script         :text
#  subtitle       :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#
# Indexes
#
#  index_announcements_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'rails_helper'

RSpec.describe Announcement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
