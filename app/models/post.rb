# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class Post < ApplicationRecord
end
