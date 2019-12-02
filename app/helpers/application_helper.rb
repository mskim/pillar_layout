module ApplicationHelper
  def current_issue
    if session[:current_issue] 
      session[:current_issue]
      Issue.find(session[:current_issue]["id"])
    else
      Issue.last
    end 
  end

  def ko_date
    current_issue.korean_date_string
  end

end
