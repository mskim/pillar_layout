# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  height     :float
#  image      :string
#  name       :string
#  text       :string
#  width      :float
#  x_value    :float
#  y_value    :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  proof_id   :bigint
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
