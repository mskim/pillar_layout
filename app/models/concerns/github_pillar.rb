module GithubPillar
  extend ActiveSupport::Concern

  def save_for_github
    save_config_file
    working_articles.each do |w|
      w.save_for_github
    end
  end

  def config_path
    path + "/pillar_config.yml"
  end

  def pillar_config_yml
    h                     = {}
    h[:height]            = height
    h[:width]             = width
    h[:height_in_lines]   = height_in_lines
    h[:root_articles_count] = root_articles_count
    h.to_yaml
  end

  def save_config_file
    File.open(config_path, 'w'){|f| f.write pillar_config_yml}
  end
end