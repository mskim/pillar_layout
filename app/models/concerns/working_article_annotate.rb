module WorkingArticleAnnotate
  extend ActiveSupport::Concern

  # create new annotation verion
  def new_annotation
    Annotation.create(working_article: self)
  end
end