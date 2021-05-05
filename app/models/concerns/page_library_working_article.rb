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
    update_image_from_disk
    update_graphic_from_disk
    update_group_graphic_from_disk

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

  def update_image_from_disk

  end

  def update_graphic_from_disk

  end

  def update_group_graphic_from_disk

  end

end