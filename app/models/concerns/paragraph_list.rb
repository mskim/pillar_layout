
 module ParagraphList
  extend ActiveSupport::Concern

  attr_reader :paragraphs
  def create_paragraphs
    @paragraphs ||= []


  end

end