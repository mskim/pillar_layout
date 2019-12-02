# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  text       :string
#  image      :string
#  x_value    :float
#  y_value    :float
#  width      :float
#  height     :float
#  proof_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_proof_id  (proof_id)
#
# Foreign Keys
#
#  fk_rails_...  (proof_id => proofs.id)
#

class Comment < ApplicationRecord
  belongs_to :proof
end
