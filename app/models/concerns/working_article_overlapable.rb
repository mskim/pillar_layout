module WorkingArticleOverlapable
  extend ActiveSupport::Concern

  def overlapable?
    column > 2 && row > 2
  end

  def create_overlap

  end

  def has_overlap?

  end

  def delete_overlap

  end

  def default_operlap_rect
    [column - 2, row - 2, 2,2]
  end
end