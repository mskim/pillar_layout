# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Rails.application.routes.url_helpers
  NEWS_LAYOUT_ENGINE = "ruby" #rubymotionn
end
