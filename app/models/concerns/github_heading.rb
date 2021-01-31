module GithubPageHeading
  extend ActiveSupport::Concern
  def save_for_github
    save_layout
  end
end