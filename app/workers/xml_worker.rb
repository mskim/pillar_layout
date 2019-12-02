class XmlWorker
    # include Sidekiq::Worker
    include SuckerPunch::Job
  
     def perform(issue_id)
      i = Issue.find(issue_id)
    #   puts i.path
    #   puts "=============="
      i.merge_container_xml
      #  i.send_mobile_preview_xml
   end 

end
  