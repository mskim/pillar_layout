# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id                 :bigint           not null, primary key
#  backup             :text
#  body               :string
#  by_line            :string
#  category_code      :string
#  category_name      :string
#  char_count         :integer
#  date               :date
#  for_front_page     :boolean
#  group              :string
#  image_name         :string
#  kind               :string
#  order              :integer
#  path               :string
#  price              :float
#  published          :boolean
#  quote              :string
#  reporter           :string
#  selected           :boolean
#  status             :string
#  story_type         :string           default("0")
#  subject_head       :string
#  subtitle           :string
#  summitted          :boolean
#  summitted_at       :time
#  summitted_section  :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  working_article_id :bigint
#
# Indexes
#
#  index_stories_on_user_id             (user_id)
#  index_stories_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (working_article_id => working_articles.id)
#

class Story < ApplicationRecord
  belongs_to :user
  belongs_to :working_article, optional: true
  before_create :init_atts
  before_save :count_chars

  has_rich_text :content

  def status_string
    selected = 'X'
    selected = 'O' if status == 'selected'
    selected
  end

  def self.start_story
    User.all.each do |user|
      puts "user.role:#{user.role}"
      if user.role == 'reporter'
        s = Story.where(user: user, date: Issue.last.date, summitted_section: user.group).first_or_create!
        puts "s.id:#{s.id}" if s
      end
    end
  end

  def update_story_from_article(body)
    self.body = body
    save
  end

  def backup
    puts __method__
    self.backup = body
    save
  end

  def recover_backup
    puts __method__
    self.body = backup
    save
  end

  def self.story_from_wire(user, wire)
    s = Story.where(user_id: user.id, title: wire.title, date: Issue.last.date).first_or_create!
    s.title = wire.title
    s.content = wire.body
    s.save
  end

  private

  def count_chars
    self.char_count = 0
    self.char_count = body.length if body
  end

  def init_atts
    self.reporter = user.name
    self.group    = user.group
    self.status   = 'draft'
    self.date     = Date.today unless date
    self.title    = "#{reporter}의 제목 입니다." unless title
    self.subtitle = "#{reporter}의 부제목 입니다." unless title
    self.body     = '본문은 여기에 입력 합니다. ' * 5 unless body
    self.char_count = body.length
    self.path = working_article.path if working_article
  end
end
