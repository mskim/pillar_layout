# == Schema Information
#
# Table name: ad_bookings
#
#  id             :bigint           not null, primary key
#  ad_list        :text
#  date           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#
# Indexes
#
#  index_ad_bookings_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class AdBooking < ApplicationRecord
  belongs_to :publication

  after_initialize :assign_default_ad_lists
  after_create :create_ad_plans

  def create_ad_plans
    ad_plan_array = eval(ad_list)
    ad_plan_array.each do |ad_item|
      item                = {}
      item[:ad_booking_id]  = id
      item[:date]           = date
      item[:page_number]    = ad_item[0]
      item[:ad_type]        = ad_item[1]
      item[:advertiser]     = ad_item[2]
      item[:color_page]     = ad_item[3] 
      AdPlan.where(item).first_or_create
    end
  end

  # create AdBooking for month of give date, first day of month
  def self.create_ad_plan_for_month(date)
    first_day = AdBooking.where(date: date).take
    unless first_day

    end
  end

  def self.create_ad_plan_for_day(date)
    AdBooking.create(date)
  end

  # get non-holidays in month
  def self.publishing_days_in_month(date)

  end

  def sample_ad_list
    list=<<~EOF
    [
      [1, "5단통","광고주1",true], 
      [3, "5단통","광고주1", true], 
      [5, "5단통","광고주1", true], 
      [7, "전면광고","광고주1", true], 
      [9, "전면광고","광고주1", true], 
      [11, "전면광고","광고주1", true], 
      [24, "전면광고","광고주1", true]
    ]
    EOF

  end

  private

  def assign_default_ad_lists
    self.publication_id = 1
    self.ad_list        = sample_ad_list
    true
  end
end
