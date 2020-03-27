# == Schema Information
#
# Table name: member_images
#
#  id                 :bigint           not null, primary key
#  caption            :string
#  member_img         :string
#  order              :integer
#  source             :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint           not null
#
# Indexes
#
#  index_member_images_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

require 'rails_helper'

RSpec.describe MemberImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
