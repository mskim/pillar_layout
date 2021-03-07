# Handle filling up working_article with sample text
# steps
# 1. first we need to build fill_text_data_info_path
#     this yml file keep key value pair of 
#     profile:char_count
# 2. Using this data we can generate sample text that fits with a given article
#     

module WorkingArticleFillupText
  extend ActiveSupport::Concern

  def sample_fillup_text
    para_text =<<~EOF
    여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다. 여기는 본문 입니다.
    
    EOF
  end

  def big_chunk_text
    s = head_text_chunk
    s +=  mediom_chunk_text
    s
  end

  def mediom_chunk_text
    small_chunk_text*5
  end

  def head_text_chunk
    "# 여기는 중간제목 입니다.\n"
  end

  def small_chunk_text
    para_text =<<~EOF
    여기는 본문 입니다. 여기는 본문 입니다. 
    EOF
  end

  def text_data_profile
    "#{pillar.page.column}_#{column}x#{height_in_lines}"
  end

  def fill_text_data_info_path
    "#{publication.fill_text_data_info_path}"
  end

  def sample_fill_text_to_fit
    text_count = YAML::load_file(fill_text_data_info_path)[text_data_profile]
    currnt_text = ""
    big_chunk_text_count  = big_chunk_text.length
    medium_text_count     = mediom_chunk_text.length
    small_text_count      = small_chunk_text.length
    
    if text_count > big_chunk_text_count
      mutlples = text_count/big_chunk_text_count
      if mutlple > 0
        currnt_text += big_chunk_text*mutlples
        text_count -= currnt_text.length
      end
    end
    if text_count > medium_text_count
      mutlples = text_count/medium_text_count
      if mutlple > 0
        currnt_text += medium_text_count*mutlples
        text_count -= currnt_text.length
      end
    end
    if text_count > small_text_count
      mutlples = text_count/small_text_count
      if mutlple > 0
        currnt_text += small_text_count*mutlples
        text_count -= currnt_text.length
      end
    end
  end

  def fillup_text(options={})
    sample_text = sample_fillup_text * grid_area
    update(body: sample_text)
    generate_pdf_with_time_stamp 
    unless options[:no_page_update]
      page.generate_pdf_with_time_stamp
    end
  end

  def fillup_text_all
    pillar.working_articles.each do |w|
      w.fillup_text(no_page_update: true)
    end
    page.generate_pdf_with_time_stamp
  end

end