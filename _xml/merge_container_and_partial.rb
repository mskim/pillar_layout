# merge Containe


particla_path = "partial_Container.xml"
page_pattern = /(<Page ID=\"100107">(.)*<\/Page>)/m

particla_text = File.open(particla_path, 'r'){|f| f.read}
# particla_text.match page_pattern
particla_text.match page_pattern

puts "$1 ++++++++ "
puts $1

