# frozen_string_literal: true

# == Schema Information
#
# Table name: yh_articles
#
#  id              :bigint           not null, primary key
#  action          :string
#  attriubute_code :string
#  body            :text
#  category        :string
#  category_code   :string
#  category_name   :string
#  char_count      :integer
#  class_code      :string
#  credit          :string
#  date            :date
#  region          :string
#  service_type    :string
#  source          :string
#  taken_by        :string
#  time            :string
#  title           :string
#  urgency         :string
#  writer          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :string
#

class YhArticle < ApplicationRecord
  # before & after
  before_save :update_category

  # validates
  validates_uniqueness_of :content_id

  # multiple_databases
  establish_connection :wire_service

  def taken(user)
    self.taken_by = user.name
    save
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
