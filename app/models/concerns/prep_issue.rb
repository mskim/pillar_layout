
module PrepPage
  extend ActiveSupport::Concern

  def prop_path
    "#{Rails.root}/public/1/issue_prep"
  end

  def create_prep_issue
    one_day_after = date + 1.day
    two_day_after = date + 2.day
    three_day_after = date + 3.day
  end



end