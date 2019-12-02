news_go_partial_content = File.open('partial_Container.xml', 'r'){|f| f.read}

newsgo_partial_array = []
24.times do |i|
  page        = (i + 1).to_s.rjust(2,"0")
  page_div    = /<Page ID="\d{4}#{page}">.*?<\/Page>/m
  result = news_go_partial_content.match(page_div)
  if result
    newsgo_partial_array << result[0]
  else
    newsgo_partial_array << nil
  end

end

base_content = File.open('Container.xml', 'r'){|f| f.read}

page_div      = /<Page ID="\d{4}21">.*?<\/Page>/m
partial_array = []
header =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<ContainerML>
	<WriteAndTime>2018-09-18T12:25:13</WriteAndTime>
	<NewsID>1</NewsID>
	<NewsName>내일신문</NewsName>
	<JeHoNum>4470</JeHoNum>
	<NewsDate>2018-09-18T00:00:00</NewsDate>
	<PanID>24</PanID>
EOF

footer =<<EOF
	</PageList>
</ContainerML>
EOF

24.times do |i|
  page        = (i + 1).to_s.rjust(2,"0")
  page_div    = /<Page ID="\d{4}#{page}">.*?<\/Page>/m
  result = base_content.match(page_div)
  if result
    partial_array << result[0]
  else
    partial_array << nil
  end

end
partial_array = partial_array.map.with_index do |e, i|
  if e.nil?
    newsgo_partial_array[i]
  else
    e
  end
end

s = header
s += partial_array.join("\n")
s += footer

puts s

# replace array element
