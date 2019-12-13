# == Schema Information
#
# Table name: yh_prs
#
#  id              :bigint           not null, primary key
#  action          :string
#  appenddata      :string
#  attriubute_code :string
#  body            :string
#  category        :string
#  class_code      :string
#  comment         :string
#  credit          :string
#  date            :date
#  region        :string
#  service_type    :string
#  source          :string
#  taken_by        :string
#  time            :time
#  title           :string
#  urgency         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :string
#

class YhPr < ApplicationRecord
    establish_connection :wire_service
    validates_uniqueness_of :content_id
  
    def source_path
        require 'date'
        today = Date.today
        today_string = today.strftime("%Y%m%d")
        filename_date = content_id.split("/").last.scan(/\d{8}/).first
        year_dir = filename_date.scan(/\d{4}/).first
        month_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).first
        day_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).last
        "/wire_source/401_PR/#{year_dir}/#{month_dir}/#{day_dir}"
        # "/Volumes/211.115.91.190/101_KOR/#{Issue.last.date_string}"
        # "/Volumes/211.115.91.190/203_GRAPHIC/#{Issue.last.date_string}"
    end

    def full_size_path
        return unless appenddata
        full_size = appenddata.split("/").last
        source_path + "/full/#{full_size}"
    end

    def preview_path
        return unless appenddata
        preview = appenddata.split("/").last
        source_path + "/pre/#{preview}"
    end

    def thumb_path
        return unless appenddata
        thumb = appenddata.split("/").last
        source_path + "/thumb/#{thumb}"
    end

    def taken(user)
        self.taken_by = user.name
        self.save
    end

    def self.delete_week_old(today)
        one_week_old = today.days_ago(7)
        YhPr.all.each do |pr|
            pr.destroy if pr.created_at < one_week_old
        end
    end
end
