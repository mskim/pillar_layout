 module WorkingArticleProogable
  extend ActiveSupport::Concern

  def create_proof_image
    
    FileUtils.mkdir_p(working_article.proof_folder) unless File.exist?(working_article.proof_folder)
    # copy current jpg file with time stamp
    proof_folder_url = 
    proof_image = 
    # return current proof image url

  end

 end