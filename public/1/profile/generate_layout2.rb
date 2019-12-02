require 'erb'
require 'pry'
template =<<~EOF
RLayout::Container.new(width:158.74015748031,  height: 75) do
  rect(x: 0, y: 10, width:158.74015748031, height: 65, fill_color:"CMYK=0,0,0,10")
  image(local_image: '<%= name %>.eps', x: 98.74015748031, y: 0, width: 60, height: 75, fill_color: 'clear')
  container(x: 0, y: 20, width:100, bottom_margin: 10, fill_color: 'clear') do
    <% if name && work && work != '""' && position && position != '""' %>
      <% if name.include?('-') %>
      text('<%= name.split("-").first.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:17, font: 'KoPubDotumPB', font_size: 9, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      <% else  %>
      text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:17, font: 'KoPubDotumPB', font_size: 9,font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      <% end  %>
      text('<%= work %>', text_alignment: 'right', from_right: 10, y:30, font: 'KoPubDotumPL', font_size: 8, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      text('<%= position %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
    <% elsif position == '""' || position == nil %>
      text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      text('<%= work %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear')
    <% elsif work == '""' || work == nil %>
      text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      text('<%= position %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
    <% end %>
  end
end
EOF


csv_path = 'data.csv'
f = File.open(csv_path, 'r'){|f| f.read}

f.each_line do |line|
  # puts "line:#{line}"
  a = []
  a = line.chomp.split(',')
  name = a[0]
  title = a[1]
  work = a[2]
  position = a[3]

  puts "++++++++ @name:#{name}"
  # puts "@position:#{@position}"
  erb   = ERB.new(template)
  layout = erb.result(binding)
  File.open("#{name}.rb", 'w'){|f| f.write layout}
end
