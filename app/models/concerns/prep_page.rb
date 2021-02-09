module PrepIssue
  extend ActiveSupport::Concern

  
  def issue
    page.issue
  end

  def prep_path
    issue.issue_prop_path + "/#{page_number}"

  end

  def create_prep_article(date, page_number, pillar_order)
    prep_path =
  end
end