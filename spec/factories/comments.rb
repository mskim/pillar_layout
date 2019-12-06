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

FactoryBot.define do
  factory :comment do
    name { "MyString" }
    text { "MyString" }
    image { "MyString" }
    x_value { 1.5 }
    y_value { 1.5 }
    width { 1.5 }
    height { 1.5 }
    proof { nil }
  end
end
