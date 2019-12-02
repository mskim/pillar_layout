# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def set_current_user
    User.current = current_user
  end

  def set_search
    # @q = Section.search(params[:q])
    @q = Section.ransack(params[:q])
    @sections = @q.result.order(:id, :created_at, :ad_type, :page_number, :column).page(session[:current_section_pagination]).reverse_order.per(10)
    @sections = Section.all if request.format == 'csv'
  end

  def current_issue
    if session[:current_issue]
      session[:current_issue]
      Issue.find(session[:current_issue]['id'])
    else
      Issue.last
    end
  end
end
