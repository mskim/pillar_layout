require 'hexapdf'

module PillarSavePdf
  extend ActiveSupport::Concern

  def merge_pillar_pdf(path_from_root, pdfs, direction)

  end

  def finalize_pdf

    region.save_pdf
  end

end
