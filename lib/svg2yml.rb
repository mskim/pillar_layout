require 'xmlsimple'
require 'yaml'

path        = ARGV[0]
ext         = File.extname(path)
output_path = path.gsub(/#{ext}/, ".yml")
xml         = File.open(path, 'r'){|f| f.read}
svg_hash   = XmlSimple.xml_in(xml)
File.open(output_path, 'w'){|f| f.write svg_hash.to_yaml}
