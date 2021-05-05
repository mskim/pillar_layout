module PageLibraryPillar
  extend ActiveSupport::Concern


  #  id                      :bigint           not null, primary key
#  box_count               :integer
#  column                  :integer
#  direction               :string
#  grid_x                  :integer
#  grid_y                  :integer
#  has_drop_article        :boolean
#  layout_with_pillar_path :text
#  order                   :integer
#  profile                 :string
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  page_id                 :bigint
#


  def update_from_disk(pillar_map)
    self.order            = pillar_map[:order]
    self.grid_x           = pillar_map[:pillar_grid_rect][0]
    self.grid_y           = pillar_map[:pillar_grid_rect][1]
    self.column           = pillar_map[:pillar_grid_rect][2]  
    self.row              = pillar_map[:pillar_grid_rect][3]
    self.save
    load_articles(pillar_map[:article_map] )
  end

  def load_articles(article_map)
    # TODO handle drop, divide, overlap
    if root_articles.length == article_map.length
      root_articles.each do |article|
        article.load_from_archived
      end
    elsif root_articles.length < article_map.length
      article_map.each_with_index do |map, i|
        if i < root_articles.length
          root_articles[i].load_from_archived
        else
          # page, pillar, pillar_order
          article_pdf_url     = map[:pdf_path]
          layout_yaml_url     = article_pdf_url.sub("/story.pdf", "/layout.yml")
          page_fullpath       = page.page_fullpath
          layout_yaml_path    = page_fullpath + "#{layout_yaml_url}"
          h = WorkingArticle.read_layout_yaml_from_disk(layout_yaml_path)
          h[:page]            = page
          h[:pillar]          = self
          h[:order]           = i + 1
          h[:pillar_order]    = "#{order}_#{i+1}"
          w = WorkingArticle.where(h).first_or_create
        end
      end
    elsif root_articles.length > article_map.length
      removing_articles = articles.length - article_map.length
      root_articles.each do |article|
        article.load_from_archived
      end
      reversed_root_articles = root_articles.reverse
      removing_articles.times do
        w = reversed_root_articles.shift
        if w
          system("rm -rf #{w.path}")
          w.destroy
        end
      end
      # 
    end
  end
end