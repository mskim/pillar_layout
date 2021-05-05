module PageLibrary
  extend ActiveSupport::Concern

  def page_library_root_path
    "#{Rails.root}/public/#{publication.id}/page_library"
  end

  def library_page_folder
    page_library_root_path + "/#{page_number}/#{ad_type}"
  end

  def library_pages
    Dir.glob("#{library_page_folder}/**")
  end

  # use this to display page thumbnails 
  def library_pages_jpg
    library_pages.map do |p| 
      Dir.glob("#{p}/*.jpg").sort.last
    end
  end

  def library_pages_jpg_url
    library_pages_jpg.map{|p| p.gsub("#{Rails.root}/public", "")}
  end

  def save_page_library
    archive_order = library_pages.length + 1
    library_path = library_page_folder + "/#{archive_order}"
    save_config_file
    working_articles.each{|w| w.save_layout_yaml}
    FileUtils.mkdir_p(library_path) unless File.exist?(library_path)
    system("cp -R #{path}/* #{library_path}/")
  end

  def remove_page_library(order)
    # remove folder with order, and update folder names
    library_path = library_page_folder + "/#{order}"
    system "rm -rf #{library_path}"
    reorder_page_library_folders
  end

  # rename folder names after one is delted
  def reorder_page_library_folders
    library_pages.each_with_index do |page_folder, i|
      if File.basename(page_folder).to_i != (i + 1)
        new_name = File.dirname(page_folder) + "/#{i+1}"
        system "mv #{page_folder} #{new_name}"
      end
    end
  end

  def load_page_library(library_order)
    copy_library_to_page_folder(library_order)
    load_config_from_disk
    load_page_heading_from_disk
    load_ad_from_disk
  end

  def copy_library_to_page_folder(library_order)
    library_path = library_page_folder + "/#{library_order}"
    # first clear current page folder 
    system "rm -r #{path}/*"
    system "cp -R #{library_path}/* #{path}/"

  end

  def read_config_hash
    config_hash = YAML::load_file(config_yml_path)
  end

  def load_config_from_disk
    @config_hash = read_config_hash
    version = @config_hash[:version]
    # if version == "2.0"
    # else
    # end
    self.page_number                  = page_number   
    self.template_id                  = @config_hash[:template_id]   
    self.section_name                 = @config_hash[:section_name]   
    self.page_heading_margin_in_lines = @config_hash[:page_heading_margin_in_lines]
    self.ad_type                      = @config_hash[:ad_type]
    self.column                       = @config_hash[:page_columns]
    self.grid_width                   = @config_hash[:grid_size][0]
    self.grid_height                  = @config_hash[:grid_size][1]
    self.lines_per_grid               = @config_hash[:lines_per_grid]
    self.width                        = @config_hash[:width]
    self.height                       = @config_hash[:height]    
    self.left_margin                  = @config_hash[:left_margin]
    self.top_margin                   = @config_hash[:top_margin]
    self.right_margin                 = @config_hash[:right_margin]
    self.bottom_margin                = @config_hash[:bottom_margin]
    self.gutter                       = @config_hash[:gutter]
    self.article_line_thickness       = @config_hash[:article_line_thickness]
    self.draw_divider                 = @config_hash[:draw_divider]
    self.save

    load_pillars(@config_hash[:pillar_map])
    load_page_heading_from_disk
    load_ad_from_disk
  end

  def load_pillars(pillar_map)
    if pillar_map.length == pillars.length
      pillars.each_with_index do |pil, i|
        pil.update_from_disk(pillar_map[i])
      end
    elsif  pillars.length > pillar_map.length 
      # delete some pillars from last 
      # diff = pillars.length - pillar_map.length
      pillars.each_with_index do |pil, i|
        pil.update_from_disk(pillar_map[i])
      end
    else pillars.length < pillar_map.length 
      pillar_map.each_with_index  do |pil, i|
        if i < pillars.length
          pillars[i].update_from_disk(pillar_map[i])
        else
          pillar_hash = pillar_map[i].dup
          h = {}
          h[:order]   = pillar_hash[:order]
          h[:grid_x]  = pillar_hash[:pillar_grid_rect][0]
          h[:grid_y]  = pillar_hash[:pillar_grid_rect][1]
          h[:column]  = pillar_hash[:pillar_grid_rect][2]
          h[:row]     = pillar_hash[:pillar_grid_rect][3]
          h[:page]    = self
          Pillar.where(h).first_or_create
        end
      end

    end
  end

  def load_page_heading_from_disk

  end

  def load_ad_from_disk
    current_ad_box = ad_boxes.first
    if current_ad_box != ad_type
      current_ad_box.change_ad_box_layout(ad_type, column)
      current_ad_box.set_image_path(@config_hash[:ad_image_path])
    end
  end
end