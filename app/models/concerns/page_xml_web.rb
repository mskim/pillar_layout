 module PageXmlWeb
  extend ActiveSupport::Concern

   
   def all_container
    year  = date.year
    month = date.month.to_s.rjust(2, "0")
    day   = date.day.to_s.rjust(2, "0")
    @page_key         = "#{year}#{month}#{day}_011001#{page_info}"

    container_xml_page_id=<<EOF
    <Page ID="1001<%= page_info %>">
      <PageKey><%= @page_key %></PageKey>
      <PageTitle>논설#{page_number - 21}</PageTitle>
      <PaperSize>A2</PaperSize>
EOF
    page_container_xml = ""
    container_xml = ""
    container = ""
    # container_xml_page = ""
    erb=ERB.new(container_xml_page_id)
    container_xml += erb.result(binding)
    working_articles.sort_by{|x| x.order}.each do |w|
      page_container_xml += w.xml_group_key_template
    end
    ad_boxes.each do |w|
      page_container_xml += w.xml_group_key_template
    end
    # container += container_xml  + "\n" + page_container_xml
    container += container_xml
    container + page_container_xml + "		</Page>" + "\n"
  end

end