# == Schema Information
#
# Table name: proofs
#
#  id                 :bigint(8)        not null, primary key
#  working_article_id :bigint(8)
#  image_url          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_proofs_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

class Proof < ApplicationRecord
  belongs_to :working_article
end
