# == Schema Information
#
# Table name: group_images
#
#  id                 :bigint           not null, primary key
#  caption            :string
#  direction          :string
#  position           :integer
#  source             :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint           not null
#
# Indexes
#
#  index_group_images_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

require 'rails_helper'

RSpec.describe GroupImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
