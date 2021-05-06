module PageLibraryWorkingArticle
  extend ActiveSupport::Concern

  def load_from_archived
    layout_hash         = YAML::load_file(layout_yaml_path).dup
    self.kind           = layout_hash[:kind]
    self.grid_width     = layout_hash[:grid_width]
    self.grid_height    = layout_hash[:grid_height]
    self.column         = layout_hash[:column]
    self.row            = layout_hash[:row]
    self.top_position   = layout_hash[:top_position]
    self.top_story      = layout_hash[:top_story]
    self.on_left_edge   = layout_hash[:on_left_edge]
    self.on_right_edge  = layout_hash[:on_right_edge]

    article_info_hash = YAML::load_file(article_info_path).dup
    self.extended_line_count = article_info_hash[:extended_line_count]
    self.save
    update_story_from_disk
    update_image_from_disk(layout_hash[:image_options])               if layout_hash[:image_options]
    update_graphic_from_disk(layout_hash[:graphic_options])           if layout_hash[:graphic_options]
    update_group_graphic_from_disk(layout_hash[:group_image_options]) if layout_hash[:group_image_options]

  end

  def update_story_from_disk
      source = File.open(story_path, 'r'){|f| f.read}
      # parse story_content
      begin
        if (md = source.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m))
            @contents = md.post_match
            @metadata = YAML.load(md.to_s)
        else
            @contents = source
        end
      rescue => e
          puts "YAML Exception reading #filename: #{e.message}"
      end
      self.title      = @metadata['title'] if @metadata['title']
      self.subtitle   = @metadata['subtitle'] if @metadata['subtitle']
      self.quote      = @metadata['quote'] if @metadata['quote']
      self.body       = @contents
      self.save

  end

  def update_image_from_disk(image_options)
    image_options.each_with_index do |image_option, i|
      h = {}
      h[:working_article]     = self
      h[:order]               = i + 1
      # find or create n-th image
      img = Image.where(h).first_or_create
      h = {}
      h[:position]            = image_option[:position]
      h[:column]              = image_option[:column]
      h[:row]                 = image_option[:row]
      h[:fit_type]            = image_option[:fit_type]
      h[:extra_height_in_lines]= image_option[:extra_height_in_lines]
      # update new options
      img.update(h)
      # set active_storate image path
      img.set_storge_image_path(image_option[:image_path])
    end
  end

  def update_graphic_from_disk(graphic_options)
    graphic_options.each_with_index do |graphic_option, i|
      h = {}
      h[:working_article]     = self
      h[:order]               = i + 1
      # find or create n-th graphic
      graphic = Graphic.where(h).first_or_create
      h = {}
      h[:position]            = graphic_option[:position]
      h[:column]              = graphic_option[:column]
      h[:row]                 = graphic_option[:row]
      h[:fit_type]            = graphic_option[:fit_type]
      h[:extra_height_in_lines]= graphic_option[:extra_height_in_lines]
      # update new options
      graphic.update(h)
      graphic.set_storage_image_path(graphic_option[:image_path])
      
    end
  end

  def update_group_graphic_from_disk(group_image_options)
    group_image_options.each_with_index do |group_image_option, i|
      h = {}
      h[:working_article]     = self
      # h[:image_path]          = group_image_option[:image_path]
      h[:position]            = group_image_option[:position]
      h[:column]              = group_image_option[:column]
      h[:row]                 = group_image_option[:row]
      h[:fit_type]            = group_image_option[:fit_type]
      h[:extra_height_in_lines]= group_image_option[:extra_height_in_lines]
      #TODO: set ActiveStorage image
      g_image = GroupImage.where(h).first_or_create
      # g_image.set_storage_image_path(group_image_option[:image_path])
    end  
  end

end