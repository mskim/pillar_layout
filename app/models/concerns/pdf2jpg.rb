module Pdf2jpg
  extend ActiveSupport::Concern
  def convert_pdf2jpg(output_path, options={})
    @pdf_folder = File.dirname(output_path)
    if options[:ratio]
      ratio = options[:ratio] || 2.0
      enlarged_path = output_path.gsub(/.pdf$/, "_enlarged.pdf")
      target = HexaPDF::Document.new
      src =  HexaPDF::Document.open(output_path)
      src.pages.each do |page|
        form = target.import(page.to_form_xobject)
        width = form.box.width * ratio
        height = form.box.height * ratio
        canvas = target.pages.add([0, 0, width, height]).canvas
        canvas.xobject(form, at: [0, 0], width: width, height: height)
      end
      target.write(enlarged_path, optimize: true)
      @enlarged_pdf_base_name = File.basename(enlarged_path)
      @jpg_base_name = File.basename(output_path).gsub(/.pdf$/, ".jpg")
      commend  = "cd #{@pdf_folder} && vips copy #{@enlarged_pdf_base_name}[n=-1] #{@jpg_base_name}"
      system(commend)
      system("rm #{enlarged_path}")
    else
      @pdf_base_name = File.basename(output_path)
      @jpg_base_name = @pdf_base_name.gsub(/.pdf$/, ".jpg")
      commend  = "cd #{@pdf_folder} && vips copy #{@pdf_base_name}[n=-1] #{@jpg_base_name}"
      system(commend)
    end
  end
end