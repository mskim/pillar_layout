# == Schema Information
#
# Table name: proofs
#
#  id                 :bigint           not null, primary key
#  image_url          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint
#
# Indexes
#
#  index_proofs_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

require 'rails_helper'

RSpec.describe Proof, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
