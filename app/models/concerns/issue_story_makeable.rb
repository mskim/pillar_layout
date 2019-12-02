module IssueStoryMakeable
  extend ActiveSupport::Concern

  def create_stories
    User.all.each do |user|
      Story.where(user:user, date:date).first_or_create!
    end
  end
end