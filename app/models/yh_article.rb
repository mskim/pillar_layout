# == Schema Information
#
# Table name: yh_articles
#
#  id              :bigint(8)        not null, primary key
#  action          :string
#  service_type    :string
#  content_id      :string
#  date            :date
#  time            :string
#  urgency         :string
#  category        :string
#  class_code      :string
#  attriubute_code :string
#  source          :string
#  credit          :string
#  region          :string
#  title           :string
#  body            :text
#  writer          :string
#  char_count      :integer
#  taken_by        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_name   :string
#  category_code   :string
#

class YhArticle < ApplicationRecord
  validates_uniqueness_of :content_id
  before_save :update_category
  
  def taken(user)
    self.taken_by = user.name
    self.save
  end

  def self.delete_week_old(today)
    one_week_old = today.days_ago(3)
    YhArticle.all.each do |article|
      article.destroy if article.created_at < one_week_old
    end
  end

  def category_name
    eval(category)[:name]
  end

  def update_category
    category_hash = eval(category)
    self.category_name = category_hash[:name]
    self.category_code = category_hash[:code]
  end
end
