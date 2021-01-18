module GithubIssue
  extend ActiveSupport::Concern

  def save_issue_for_github
    pages.each do |p|
      p.save_for_github
    end
  end

  def github_folder_path
    publication.path + "/issues"
  end

  def push_to_github
    system("cd #{github_folder_path} && push")
  end
end